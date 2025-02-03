import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';

class AudioPlayerState {
  AudioPlayer audioPlayer;
  StreamSubscription? playerStateSubscription;
  bool isPlaying;
  int index;
  SongEntity? currentSong;
  List<SongEntity> nextSong;
  bool isbuffering;

  AudioPlayerState(
      this.audioPlayer,
      this.playerStateSubscription,
      this.isPlaying,
      this.index,
      this.currentSong,
      this.nextSong,
      this.isbuffering);

  AudioPlayerState copyWith(
          {AudioPlayer? audioPlayer,
          StreamSubscription? playerStateSubscription,
          bool? isPlaying,
          int? index,
          SongEntity? currentSong,
          List<SongEntity>? nextSong,
          bool? isbuffering}) =>
      AudioPlayerState(
          audioPlayer ?? this.audioPlayer,
          playerStateSubscription ?? this.playerStateSubscription,
          isPlaying ?? this.isPlaying,
          index ?? this.index,
          currentSong ?? this.currentSong,
          nextSong ?? this.nextSong,
          isbuffering ?? this.isPlaying);
}

class AudioPlayerViewModel extends AutoDisposeNotifier<AudioPlayerState> {
  @override
  AudioPlayerState build() {
    return AudioPlayerState(AudioPlayer(), null, false, -1, null, [], false);
  }

  /// 오디오 플레이어에 현재 곡 정보 저장
  void setCurrentSong(SongEntity song) {
    state.currentSong = song;
  }

  /// 오디오 플레이어에 다음곡 정보 저장
  void setNextSong(SongEntity song) {
    state.nextSong.add(song);
  }

  /// 오디오 플레이어에 다음곡 무더기 저장
  void setNextSongList(List<SongEntity> songList) {
    for (var list in songList) {
      log('리스트 추가 : ${list.title}');
    }
    state.nextSong.addAll(songList);
  }

  /// 오디오 연결 + 스트림 연결 및 자동재생
  Future<void> setAudioPlayer(String audioUrl, int index) async {
    if (index == state.index) {
      await togglePlay();
      return;
    }

    if (state.playerStateSubscription != null) {
      await toggleStop();
    }

    // -1 : 아무 곡도 할당되지 않은 상태
    // -2 : 플레이리스트 연속 재생 상태 (재생버튼 눌렀을 경우 다시 처음부터 재생되도록)
    // 0 ~ 4 : Card 추천곡 트는 상태 (같은곡을 재생했을 경우 재생상태 이어가기)
    if (index != -2) {
      state.index = index;
    }

    try {
      await state.audioPlayer.setUrl(audioUrl, preload: true);

      state.playerStateSubscription ??=
          state.audioPlayer.playerStateStream.listen((playerState) async {
        if (playerState.processingState == ProcessingState.completed) {
          if (state.nextSong.isEmpty) {
            await state.audioPlayer.seek(Duration.zero);
            await togglePause();
          } else {
            state = state.copyWith(currentSong: state.nextSong.first);
            await state.audioPlayer
                .setUrl(state.nextSong.first.video.audioUrl, preload: true);
            await togglePlay();
            state.nextSong.removeAt(0);
          }
        }
        if (playerState.processingState == ProcessingState.buffering) {
          state.isbuffering = true;
        }
        if (playerState.processingState == ProcessingState.loading) {
          state.isbuffering = true;
        }
        if (playerState.processingState == ProcessingState.ready) {
          state.isbuffering = false;
        }
      });

      await togglePlay();
    } catch (e) {
      log('잘못된 오디오 url 이거나, 인터넷 연결 문제 \n$e');
    }
  }

  /// 오디오 재생
  Future<void> togglePlay() async {
    if (state.isPlaying) {
      return;
    }

    state = state.copyWith(isPlaying: true);

    await waitBuffering();
  }

  Future<void> waitBuffering() async {
    if (state.isbuffering) {
      await Future.delayed(Duration(milliseconds: 500));
    }
    await state.audioPlayer.play();
  }

  /// 오디오 일시정지
  Future<void> togglePause() async {
    state = state.copyWith(isPlaying: false);
    await state.audioPlayer.pause();
  }

  /// 오디오 완전 정지, 재시작 시 새로운 설정 필요
  Future<void> toggleStop() async {
    try {
      await state.audioPlayer.stop();
      state.isPlaying = false;

      await state.playerStateSubscription?.cancel();
      state.playerStateSubscription = null;
    } catch (e) {
      print("오디오 스트림 취소시 오류 $e");
    } finally {
      state = state.copyWith(index: -1, currentSong: null, nextSong: []);
    }
  }

  /// 오디오 앞으로 건너뛰기
  /// 건너뛰기시 버퍼링(노이즈) 문제를 위해 pause후 다시 play
  Future<void> skipForwardSec(int sec) async {
    if (state.isPlaying) {
      await state.audioPlayer.pause();
    }

    final duration = state.audioPlayer.duration! - Duration(milliseconds: 100);
    final currentPosition = state.audioPlayer.position;
    final newPosition = currentPosition + Duration(seconds: sec);

    if (newPosition > duration) {
      await state.audioPlayer.seek(duration);
    } else {
      await state.audioPlayer.seek(newPosition);
    }

    if (state.isPlaying) {
      await waitBuffering();
    }
  }

  /// 오디오 뒤 건너뛰기
  /// 건너뛰기시 버퍼링(노이즈) 문제를 위해 pause후 다시 play
  Future<void> skipBackwardSec(int sec) async {
    if (state.isPlaying) {
      await state.audioPlayer.pause();
    }

    final currentPosition = state.audioPlayer.position;
    final newPosition = currentPosition - Duration(seconds: sec);

    if (newPosition < Duration.zero) {
      await state.audioPlayer.seek(Duration.zero);
    } else {
      await state.audioPlayer.seek(newPosition);
    }

    if (state.isPlaying) {
      await waitBuffering();
    }
  }

  /// 오디오 앞으로 건너뛰기
  /// 건너뛰기시 버퍼링(노이즈) 문제를 위해 pause후 다시 play
  Future<void> skipForwardPosition(Duration pos) async {
    if (state.isPlaying) {
      await state.audioPlayer.pause();
    }

    final newPosition = pos;
    await state.audioPlayer.seek(newPosition);

    if (state.isPlaying) {
      await waitBuffering();
    }
  }

  /// 새로운 오디오플레이어 객체를 사용할때
  void updateAudioPlayer(AudioPlayer player) {
    state = state.copyWith(audioPlayer: player);
  }
}

final audioPlayerViewModelProvider =
    AutoDisposeNotifierProvider<AudioPlayerViewModel, AudioPlayerState>(() {
  return AudioPlayerViewModel();
});

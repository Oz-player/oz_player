import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerState {
  AudioPlayer audioPlayer;
  StreamSubscription? playerStateSubscription;
  bool isPlaying;

  AudioPlayerState(
      this.audioPlayer, this.playerStateSubscription, this.isPlaying);

  AudioPlayerState copyWith({
    AudioPlayer? audioPlayer,
    StreamSubscription? playerStateSubscription,
    bool? isPlaying,
  }) =>
      AudioPlayerState(
          audioPlayer ?? this.audioPlayer,
          playerStateSubscription ?? this.playerStateSubscription,
          isPlaying ?? this.isPlaying);
}

class AudioPlayerViewModel extends Notifier<AudioPlayerState> {
  @override
  AudioPlayerState build() {
    return AudioPlayerState(AudioPlayer(), null, false);
  }

  /// 오디오 연결 + 스트림 연결 및 자동재생
  Future<void> setAudioPlayer(String audioUrl) async {
    if (state.playerStateSubscription != null) {
      await toggleStop();
    }

    try {
      await state.audioPlayer.setUrl(audioUrl, preload: true);

      state.playerStateSubscription ??=
          state.audioPlayer.playerStateStream.listen((playerState) async {
        if (playerState.processingState == ProcessingState.completed) {
          state.isPlaying = false;
          await state.audioPlayer.seek(Duration.zero);
        }
      });

      await togglePlay();
    } catch (e) {
      log('잘못된 url 이거나, 인터넷 연결 문제 \n$e');
    }
  }

  /// 오디오 재생
  bool isToggling = false;

  Future<void> togglePlay() async {
    if (state.playerStateSubscription == null ||
        state.isPlaying ||
        isToggling) {
      return;
    }

    isToggling = true;

    try {
      await for (var playerState in state.audioPlayer.playerStateStream
          .timeout(Duration(seconds: 20))) {
        if (playerState.processingState == ProcessingState.buffering) {
          continue;
        } else if (playerState.processingState == ProcessingState.ready) {
          await state.audioPlayer.play();
          state = state.copyWith(isPlaying: true);
          break;
        }
      }
    } catch (e) {
      print("Stream timeout or error: $e");
    } finally {
      isToggling = false;
    }
  }

  /// 오디오 일시정지
  Future<void> togglePause() async {
    await state.audioPlayer.pause();
    state.isPlaying = false;
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
    }
  }

  /// 오디오 앞으로 건너뛰기
  /// 건너뛰기시 버퍼링(노이즈) 문제를 위해 pause후 다시 play
  Future<void> skipForwardSec(int sec) async {
    if (state.isPlaying) {
      await state.audioPlayer.pause();
    }

    final duration = state.audioPlayer.duration;
    final currentPosition = state.audioPlayer.position;
    final newPosition = currentPosition + Duration(seconds: sec);

    if (newPosition > duration!) {
      await state.audioPlayer.seek(duration);
    } else {
      await state.audioPlayer.seek(newPosition);
    }

    if (state.isPlaying) {
      try {
        await for (var playerState in state.audioPlayer.playerStateStream
            .timeout(Duration(seconds: 20))) {
          if (playerState.processingState == ProcessingState.buffering) {
            continue;
          } else if (playerState.processingState == ProcessingState.ready) {
            await state.audioPlayer.play();
            break;
          }
        }
      } catch (e) {
        print("앞으로 건너뛰기시 타임오류 $e");
      }
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

    if (newPosition < Duration(seconds: 0)) {
      await state.audioPlayer.seek(Duration(seconds: 0));
    } else {
      await state.audioPlayer.seek(newPosition);
    }

    if (state.isPlaying) {
      try {
        await for (var playerState in state.audioPlayer.playerStateStream
            .timeout(Duration(seconds: 20))) {
          if (playerState.processingState == ProcessingState.buffering) {
            continue;
          } else if (playerState.processingState == ProcessingState.ready) {
            await state.audioPlayer.play();
            break;
          }
        }
      } catch (e) {
        print("뒤로 건너뛰기시 타임오류 $e");
      }
    }
  }

  /// 오디오 앞으로 건너뛰기
  /// 건너뛰기시 버퍼링(노이즈) 문제를 위해 pause후 다시 play
  Future<void> skipForwardPosition(Duration pos) async {
    await state.audioPlayer.pause();
    final newPosition = pos;

    await state.audioPlayer.seek(newPosition);

    await for (var playerState
        in state.audioPlayer.playerStateStream.timeout(Duration(seconds: 20))) {
      if (playerState.processingState == ProcessingState.buffering) {
        continue;
      } else if (playerState.processingState == ProcessingState.ready) {
        await state.audioPlayer.play();
        break;
      }
    }
  }

  /// 새로운 오디오플레이어 객체를 사용할때
  void updateAudioPlayer(AudioPlayer player) {
    state = state.copyWith(audioPlayer: player);
  }
}

final audioPlayerViewModelProvider =
    NotifierProvider<AudioPlayerViewModel, AudioPlayerState>(() {
  return AudioPlayerViewModel();
});

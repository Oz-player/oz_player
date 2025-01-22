import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:oz_player/providers.dart';

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

  /// 오디오 연결
  void setAudioPlayer(String songName, String artist) async {
    try {
      final video = await ref
          .read(videoInfoUsecaseProvider)
          .getVideoInfo(songName, artist);
      await state.audioPlayer.setUrl(video.audioUrl, preload: true);

      state = state.copyWith();

      state.playerStateSubscription ??=
          state.audioPlayer.playerStateStream.listen((playerState) {
        if (playerState.processingState == ProcessingState.completed) {
          state.isPlaying = false;
        }
      });
    } catch (e) {
      log('잘못된 url 이거나, 인터넷 연결 문제 \n$e');
    }
  }

  /// 오디오 재생
  /// 오디오가 이미 completed 상태이면, 처음부터 다시 재생
  /// 오디오 재생시 버퍼링중이면, 버퍼링을 기다렸다가 실행
  void togglePlay() async {
    if (state.playerStateSubscription == null) {
      return;
    }

    if (state.isPlaying == false) {
      if (state.audioPlayer.processingState == ProcessingState.completed) {
        await state.audioPlayer.seek(Duration.zero);

        await for (var playerState in state.audioPlayer.playerStateStream) {
          if (playerState.processingState == ProcessingState.buffering) {
            continue;
          } else if (playerState.processingState == ProcessingState.ready) {
            await state.audioPlayer.play();
            state.isPlaying = true;
            break;
          }
        }
      } else {
        await state.audioPlayer.play();
        state.isPlaying = true;
      }
    } else {
      return;
    }
  }

  /// 오디오 일시정지
  void togglePause() async {
    await state.audioPlayer.pause();
    state.isPlaying = false;
  }

  /// 오디오 완전 정지, 재시작 시 새로운 설정 필요
  void toggleStop() async {
    await state.audioPlayer.stop();
    state.isPlaying = false;

    state.playerStateSubscription?.cancel();
    state.playerStateSubscription = null;
  }

  /// 오디오 앞으로 건너뛰기
  /// 건너뛰기시 버퍼링(노이즈) 문제를 위해 pause후 다시 play
  void skipForwardSec(int sec) async {
    await state.audioPlayer.pause();
    final duration = state.audioPlayer.duration;
    final currentPosition = state.audioPlayer.position;
    final newPosition = currentPosition + Duration(seconds: sec);

    if (newPosition > duration!) {
      await state.audioPlayer.seek(duration);
    } else {
      await state.audioPlayer.seek(newPosition);
    }

    await for (var playerState in state.audioPlayer.playerStateStream) {
      if (playerState.processingState == ProcessingState.buffering) {
        continue;
      } else if (playerState.processingState == ProcessingState.ready) {
        await state.audioPlayer.play();
        break;
      }
    }
  }

  /// 오디오 앞으로 건너뛰기
  /// 건너뛰기시 버퍼링(노이즈) 문제를 위해 pause후 다시 play
  void skipForwardPosition(Duration pos) async {
    await state.audioPlayer.pause();
    final newPosition = pos;

    await state.audioPlayer.seek(newPosition);

    await for (var playerState in state.audioPlayer.playerStateStream) {
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

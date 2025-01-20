import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:oz_player/domain/usecase/video_info_usecase.dart';

class AudioPlayerState {
  AudioPlayer audioPlayer;
  bool isPlaying;

  AudioPlayerState(this.audioPlayer, this.isPlaying);

  AudioPlayerState copyWith({
    AudioPlayer? audioPlayer,
    bool? isPlaying,
  }) =>
      AudioPlayerState(
          audioPlayer ?? this.audioPlayer, isPlaying ?? this.isPlaying);
}

class AudioPlayerViewModel extends Notifier<AudioPlayerState> {
  StreamSubscription? _playerStateSubscription;

  @override
  AudioPlayerState build() {
    return AudioPlayerState(AudioPlayer(), false);
  }

  /// 오디오 연결
  void setAudioPlayer(String songName, String artist) async {
    final video =
        await ref.read(videoInfoUsecaseProvider).getVideoInfo(songName, artist);
    await state.audioPlayer.setUrl(video.audioUrl, preload: true);

    _playerStateSubscription ??=
        state.audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        state.isPlaying = false;
      }
    });
  }

  /// 오디오 재생
  void togglePlay() async {
    if(_playerStateSubscription == null){
      return;
    }

    if (state.isPlaying == false) {
      if (state.audioPlayer.processingState == ProcessingState.completed) {
        await state.audioPlayer.seek(Duration.zero);
        await state.audioPlayer.play();
        state.isPlaying = true;
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

  /// 오디오 스톱 및 연결 오디오 제거
  void toggleStop() async {
    await state.audioPlayer.stop();
    state.isPlaying = false;

    // stop 후에는 리스너를 해제
    _playerStateSubscription?.cancel();
    _playerStateSubscription = null;
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
    await state.audioPlayer.play();
  }

    /// 오디오 앞으로 건너뛰기
  /// 건너뛰기시 버퍼링(노이즈) 문제를 위해 pause후 다시 play
  void skipForwardPosition(Duration pos) async {
    await state.audioPlayer.pause();
    final newPosition = pos;

    await state.audioPlayer.seek(newPosition);
    await state.audioPlayer.play();
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

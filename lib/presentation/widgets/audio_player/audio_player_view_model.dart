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
    if (state.isPlaying == false || state.audioPlayer.processingState == ProcessingState.completed) {
      await state.audioPlayer.play();
      state.isPlaying = true;
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

  void updateAudioPlayer(AudioPlayer player) {
    state = state.copyWith(audioPlayer: player);
  }
}

final audioPlayerViewModelProvider =
    NotifierProvider<AudioPlayerViewModel, AudioPlayerState>(() {
  return AudioPlayerViewModel();
});

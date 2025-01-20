import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:oz_player/data/repository_impl/video_info_repository_impl.dart';
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

class AudioPlayerViewModel extends StateNotifier<AudioPlayerState> {
  AudioPlayerViewModel() : super(AudioPlayerState(AudioPlayer(), false));

  /// 오디오 연결
  void setAudioPlayer(String songName, String artist) async {
    final videoInfoRepository = VideoInfoRepositoryImpl();
    final videoInfoUsecase = VideoInfoUsecase(videoInfoRepository);

    final video = await videoInfoUsecase.getVideoInfo(songName, artist);
    await state.audioPlayer.setUrl(video.audioUrl);
  }

  /// 오디오 재생
  void togglePlay() async {
    await state.audioPlayer.play();
    state.isPlaying = true;
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
  }

  void updateAudioPlayer(AudioPlayer player) {
    state = state.copyWith(audioPlayer: player);
  }
}

final audioPlayerViewModelProvider =
    StateNotifierProvider<AudioPlayerViewModel, AudioPlayerState>((ref) {
  return AudioPlayerViewModel();
});

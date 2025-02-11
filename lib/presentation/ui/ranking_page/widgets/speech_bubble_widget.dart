import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/ui/ranking_page/view_model/ranking_view_model.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_bottomsheet.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';
import 'package:oz_player/presentation/widgets/speech_ballon/speech_ballon.dart';

class SpeechBubbleWidget extends ConsumerWidget {
  const SpeechBubbleWidget(this.data, {super.key, this.nipLocation, this.song});

  final RawSongEntity? song;
  final NipLocation? nipLocation;
  final RankingState data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(audioPlayerViewModelProvider);

    if (song == null) {
      return SpeechBalloon(
          nipLocation: nipLocation ?? NipLocation.bottom,
          borderRadius: 8,
          nipHeight: 20,
          color: Colors.black.withValues(alpha: 0.32),
          width: 230,
          height: 120,
          child: Center(
              child: Text(
            '랭킹 확인 중입니다',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          )));
    }
    return SpeechBalloon(
        nipLocation: nipLocation ?? NipLocation.bottom,
        borderRadius: 8,
        nipHeight: 20,
        color: Colors.black.withValues(alpha: 0.32),
        width: 256,
        height: 120,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                ),
                SizedBox(
                    width: 60, height: 60, child: Image.network(song!.imgUrl)),
                SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 130,
                      child: AutoSizeText(
                        song!.title,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 14,
                        maxLines: 1,
                        wrapWords: false,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: AutoSizeText(
                        song!.artist,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 12,
                        maxLines: 1,
                        wrapWords: false,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
            Positioned(
                right: 16,
                bottom: 16,
                child: GestureDetector(
                  onTap: () {
                    if (audioState.currentSong?.title == song!.title &&
                        audioState.currentSong?.artist == song!.artist &&
                        audioState.isPlaying) {
                      AudioBottomSheet.showCurrentAudio(context);
                    } else {
                      ref
                          .read(audioPlayerViewModelProvider.notifier)
                          .toggleStop();

                      AudioBottomSheet.showCurrentAudio(context);

                      ref
                          .read(audioPlayerViewModelProvider.notifier)
                          .isStartLoadingAudioPlayer();

                      SongEntity playSong = SongEntity(
                          video: song!.video,
                          title: song!.title,
                          imgUrl: song!.imgUrl,
                          artist: song!.artist,
                          mood: '',
                          situation: '',
                          genre: '',
                          favoriteArtist: '');

                      ref
                          .read(audioPlayerViewModelProvider.notifier)
                          .setCurrentSong(playSong);

                      ref
                          .read(audioPlayerViewModelProvider.notifier)
                          .setAudioPlayer(playSong.video.audioUrl, -2);
                    }
                  },
                  child: Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 28,
                  ),
                )),
            if (data.focusIndex == FocusIndex.firstPrice)
              Positioned(
                top: -30,
                child: Image.asset('assets/images/crown_gold.png'),
              ),
            if (data.focusIndex == FocusIndex.secondPrice)
              Positioned(
                top: -30,
                child: Image.asset('assets/images/crown_sliver.png'),
              ),
            if (data.focusIndex == FocusIndex.thirdPrice)
              Positioned(
                top: -30,
                child: Image.asset('assets/images/crown_bronze.png'),
              ),
          ],
        ));
  }
}

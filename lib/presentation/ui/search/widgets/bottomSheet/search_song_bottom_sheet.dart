import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/providers/login/providers.dart';
import 'package:oz_player/presentation/ui/search/widgets/bottomSheet/bottom_sheet_button.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_bottomsheet.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';

class SearchSongBottomSheet extends StatelessWidget {
  const SearchSongBottomSheet(
      {super.key,
      required this.imgUrl,
      required this.artist,
      required this.title});

  final String imgUrl;
  final String artist;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
      child: Consumer(
        builder: (context, ref, child) {
          final audioState = ref.watch(audioPlayerViewModelProvider);

          return Container(
            height: 248,
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3.43),
                          child: Image.network(
                            imgUrl,
                            width: 56,
                            height: 56,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          child: Text(
                            artist,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 25),
                    bottomSheetButton(context, '재생', () async {
                      if (audioState.currentSong?.title == title &&
                          audioState.currentSong?.artist == artist) {
                        AudioBottomSheet.showCurrentAudio(context);
                      } else {
                        ref
                            .read(audioPlayerViewModelProvider.notifier)
                            .toggleStop();

                        AudioBottomSheet.showCurrentAudio(context);

                        ref
                            .read(audioPlayerViewModelProvider.notifier)
                            .isStartLoadingAudioPlayer();

                        final videoEx = ref.read(videoInfoUsecaseProvider);
                        final video = await videoEx.getVideoInfo(title, artist);

                        final song = SongEntity(
                            video: video,
                            title: title,
                            imgUrl: imgUrl,
                            artist: artist,
                            mood: 'mood',
                            situation: 'situation',
                            genre: 'genre',
                            favoriteArtist: 'favoriteArtist');

                        ref
                            .read(audioPlayerViewModelProvider.notifier)
                            .setCurrentSong(song);

                        ref
                            .read(audioPlayerViewModelProvider.notifier)
                            .isEndLoadingAudioPlayer();
                        await ref
                            .read(audioPlayerViewModelProvider.notifier)
                            .setAudioPlayer(song.video.audioUrl, -2);
                      }
                    }),
                    SizedBox(height: 10),
                    bottomSheetButton(context, '플레이리스트에 저장', () {}),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

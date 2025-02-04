import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/providers/login/providers.dart';
import 'package:oz_player/presentation/ui/search/widgets/bottomSheet/bottom_sheet_button.dart';
import 'package:oz_player/presentation/ui/search/widgets/bottomSheet/lyrics_bottom.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_bottomsheet.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';

class SearchLyicsBottomSheet extends StatelessWidget {
  const SearchLyicsBottomSheet({
    super.key,
    required this.song,
    required this.artist,
    required this.lyrics
  });

  final String song;
  final String artist;
  final String lyrics;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
      child: Consumer(
        builder: (context, ref, child) {
          final audioState = ref.watch(audioPlayerViewModelProvider);

          return Container(
            height: 300,
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Text(
                              song,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          height: 50,
                        ),
                        SizedBox(
                          child: Text(
                            artist,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 25),
                    bottomSheetButton(context, '가사 보기', () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return LyricsBottom(song: song, artist: artist, lyrics: lyrics);
                          });
                    }),
                    SizedBox(height: 10),
                    bottomSheetButton(context, '재생', () async {
                      if (audioState.currentSong?.title == song &&
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

                        // 비디오 정보 호출
                        final videoEx = ref.read(videoInfoUsecaseProvider);
                        final video = await videoEx.getVideoInfo(song, artist);

                        // imgUrl 받기
                        final spotifyDB = ref.read(spotifySourceProvider);
                        final searchSong =
                            await spotifyDB.searchList('$artist - $song}');
                        final album = searchSong[0].album;
                        final albumImges = album!['images'][0];
                        final imgUrl = albumImges['url'];

                        final songtity = SongEntity(
                            video: video,
                            title: song,
                            imgUrl: imgUrl,
                            artist: artist,
                            mood: 'mood',
                            situation: 'situation',
                            genre: 'genre',
                            favoriteArtist: 'favoriteArtist');

                        ref
                            .read(audioPlayerViewModelProvider.notifier)
                            .setCurrentSong(songtity);

                        await ref
                            .read(audioPlayerViewModelProvider.notifier)
                            .setAudioPlayer(songtity.video.audioUrl, -2);
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


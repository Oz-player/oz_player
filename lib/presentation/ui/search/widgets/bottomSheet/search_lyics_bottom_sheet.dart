import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/providers/login/providers.dart';
import 'package:oz_player/presentation/ui/recommend_page/widgets/save_playlist_bottom_sheet.dart';
import 'package:oz_player/presentation/ui/search/widgets/bottomSheet/bottom_sheet_button.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_bottomsheet.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';
import 'package:oz_player/presentation/widgets/loading/loading_view_model/loading_view_model.dart';
import 'package:oz_player/presentation/widgets/toast_message/toast_message.dart';

class SearchLyicsBottomSheet extends StatelessWidget {
  const SearchLyicsBottomSheet(
      {super.key,
      required this.song,
      required this.artist,
      required this.lyrics});

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
          final loadingState = ref.watch(loadingViewModelProvider);

          return loadingState.isLoading
              ? SizedBox.shrink()
              : Container(
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
                            context.push('/search/lyrics', extra: {
                              'song': song,
                              'artist': artist,
                              'lyrics': lyrics,
                            });
                          }),
                          SizedBox(height: 10),
                          bottomSheetButton(context, '재생', () async {
                            if (audioState.currentSong?.title == song &&
                                audioState.currentSong?.artist == artist &&
                                audioState.isPlaying) {
                              AudioBottomSheet.showCurrentAudio(context);
                            } else {
                              await ref
                                  .read(audioPlayerViewModelProvider.notifier)
                                  .toggleStop();

                              if (context.mounted) {
                                AudioBottomSheet.showCurrentAudio(context);
                              }

                              ref
                                  .read(audioPlayerViewModelProvider.notifier)
                                  .isStartLoadingAudioPlayer();

                              // imgUrl 받기
                              final spotifyDB = ref.read(spotifySourceProvider);
                              final searchSong = await spotifyDB
                                  .searchList('$artist - $song}');
                              final album = searchSong[0].album;
                              final albumImges = album!['images'][0];
                              final imgUrl = albumImges['url'];

                              try {
                                // 비디오 정보 호출
                                final videoEx =
                                    ref.read(videoInfoUsecaseProvider);
                                final video =
                                    await videoEx.getVideoInfo(song, artist);

                                if (video.audioUrl == '' && video.id == '') {
                                  throw 'Video is EMPTY';
                                }

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
                                    .setAudioPlayer(
                                        songtity.video.audioUrl, -2);
                              } catch (e) {
                                log('오디오를 불러오는데 실패했습니다');
                                ref
                                    .read(audioPlayerViewModelProvider.notifier)
                                    .isEndLoadingAudioPlayer();
                                if (context.mounted) {
                                  ToastMessage.showErrorMessage(context);
                                  context.pop();
                                }
                              }
                            }
                          }),
                          SizedBox(height: 10),
                          bottomSheetButton(context, '플레이리스트에 저장', () async {
                            //ref.watch(playListsUsecaseProvider).addSong(listName, entity)
                            if (ref.watch(loadingViewModelProvider).isLoading) {
                              return;
                            }

                            ref
                                .read(loadingViewModelProvider.notifier)
                                .startLoading(4);

                            final spotifyDB = ref.read(spotifySourceProvider);
                            final searchSong =
                                await spotifyDB.searchList('$artist - $song}');
                            final album = searchSong[0].album;
                            final albumImges = album!['images'][0];
                            final imgUrl = albumImges['url'];

                            try {
                              final videoEx =
                                  ref.read(videoInfoUsecaseProvider);
                              final video =
                                  await videoEx.getVideoInfo(song, artist);
                              if (video.audioUrl == '' && video.id == '') {
                                throw 'Video is EMPTY';
                              }
                              TextEditingController titleController =
                                  TextEditingController();
                              TextEditingController descriptionController =
                                  TextEditingController();
                              final newEntity = SongEntity(
                                  video: video,
                                  title: song,
                                  imgUrl: imgUrl,
                                  artist: artist,
                                  mood: 'mood',
                                  situation: 'situation',
                                  genre: 'genre',
                                  favoriteArtist: 'favoriteArtist');
                              if (context.mounted) {
                                SavePlaylistBottomSheet.show(
                                    context,
                                    ref,
                                    titleController,
                                    descriptionController,
                                    newEntity);
                              }
                            } catch (e) {
                              log('오디오를 불러오는데 실패했습니다');
                              if (context.mounted) {
                                ToastMessage.showErrorMessage(context);
                              }
                            } finally {
                              ref
                                  .read(loadingViewModelProvider.notifier)
                                  .endLoading();
                            }
                          }),
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

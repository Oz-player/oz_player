import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/app/logic/isvaildurl.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_bottomsheet.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({super.key, this.colorMode});

  // 회색(하얀배경일때) : true, 하얀색(검은배경일때) : false
  final dynamic colorMode;

  @override
  Widget build(BuildContext context) {
    return Semantics(label: '오디오 플레이어', child: bottomAudioPlayer(colorMode));
  }

  Widget bottomAudioPlayer(bool colorMode) {
    return Consumer(
      builder: (context, ref, child) {
        final audioState = ref.watch(audioPlayerViewModelProvider);

        if (audioState.loadingAudio) {
          return audioBox(audioState, ref, context);
        } else {
          if (audioState.playerStateSubscription == null ||
              audioState.currentSong == null) {
            return SizedBox.shrink();
          }
          return audioBox(audioState, ref, context);
        }
      },
    );
  }

  Widget audioBox(
      AudioPlayerState audioState, WidgetRef ref, BuildContext context) {
    if (audioState.loadingAudio) {
      return GestureDetector(
        onTap: () {
          AudioBottomSheet.showCurrentAudio(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter:
                        ImageFilter.blur(sigmaX: 10, sigmaY: 10), // 블러 강도 조정
                    child: Container(
                      width: double.infinity,
                      height: 60, // 높이 설정
                      color: colorMode
                          ? Colors.black.withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.3), // 흐림 효과 배경 색상
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(12)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: audioState.loadingAudio
                              ? Center(child: CircularProgressIndicator())
                              : isValidUrl(audioState.currentSong!.imgUrl)
                                  ? Image.network(
                                      audioState.currentSong!.imgUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    )
                                  : Image.asset(
                                      'assets/images/muoz.png',
                                      fit: BoxFit.contain,
                                    ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              audioState.loadingAudio
                                  ? '음악 로딩중'
                                  : audioState.currentSong!.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              audioState.loadingAudio
                                  ? '잠시만 기다려주세요'
                                  : audioState.currentSong!.artist,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            if (audioState.isPlaying) {
                              ref
                                  .read(audioPlayerViewModelProvider.notifier)
                                  .togglePause();
                            } else {
                              ref
                                  .read(audioPlayerViewModelProvider.notifier)
                                  .togglePlay();
                            }
                          },
                          icon: Icon(
                            audioState.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 38,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Dismissible(
      key: Key('audio_player'),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        ref.read(audioPlayerViewModelProvider.notifier).toggleStop();
      },
      child: GestureDetector(
        onTap: () {
          AudioBottomSheet.showCurrentAudio(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter:
                        ImageFilter.blur(sigmaX: 10, sigmaY: 10), // 블러 강도 조정
                    child: Container(
                      width: double.infinity,
                      height: 60, // 높이 설정
                      color: colorMode
                          ? Colors.black.withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.3), // 흐림 효과 배경 색상
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(12)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: audioState.loadingAudio
                              ? Center(child: CircularProgressIndicator())
                              : isValidUrl(audioState.currentSong!.imgUrl)
                                  ? Image.network(
                                      audioState.currentSong!.imgUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    )
                                  : Image.asset(
                                      'assets/images/muoz.png',
                                      fit: BoxFit.contain,
                                    ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              audioState.loadingAudio
                                  ? '음악 로딩중'
                                  : audioState.currentSong!.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              audioState.loadingAudio
                                  ? '잠시만 기다려주세요'
                                  : audioState.currentSong!.artist,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            if (audioState.isPlaying) {
                              ref
                                  .read(audioPlayerViewModelProvider.notifier)
                                  .togglePause();
                            } else {
                              ref
                                  .read(audioPlayerViewModelProvider.notifier)
                                  .togglePlay();
                            }
                          },
                          icon: Icon(
                            audioState.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 38,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

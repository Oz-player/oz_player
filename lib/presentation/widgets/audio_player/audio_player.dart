import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/app/logic/isvaildurl.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_bottomsheet.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({super.key, this.colorMode});

  // 회색(하얀배경일때) : true, 하얀색(검은배경일때) : false
  final colorMode;

  @override
  Widget build(BuildContext context) {
    return bottomAudioPlayer(colorMode);
  }

  Widget bottomAudioPlayer(bool colorMode) {
    return Consumer(
      builder: (context, ref, child) {
        final audioState = ref.watch(audioPlayerViewModelProvider);
        if (audioState.playerStateSubscription == null ||
            audioState.currentSong == null) {
          return SizedBox.shrink();
        }
        return Dismissible(
          key: Key('audio_player'),
          direction: DismissDirection.horizontal,
          onDismissed:(direction) {
            ref.read(audioPlayerViewModelProvider.notifier).toggleStop();
          },
          child: GestureDetector(
            onTap: (){
              AudioBottomSheet.showCurrentAudio(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: colorMode
                      ? Colors.black.withValues(alpha: 0.32)
                      : Colors.white.withValues(alpha: 0.32),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
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
                            child: isValidUrl(audioState.currentSong!.imgUrl)
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
                          width: 16,
                        ),
                        Text(
                          audioState.currentSong!.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white),
                          overflow: TextOverflow.ellipsis,
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
                              audioState.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 38,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

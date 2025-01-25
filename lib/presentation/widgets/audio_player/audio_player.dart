import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return bottomAudioPlayer();
  }

  /*
  Widget fullAudioPlayer() {
    return Consumer(
      builder: (context, ref, child) {
        final audioState = ref.watch(audioPlayerViewModelProvider);
        
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: StreamBuilder(
                stream: audioState.audioPlayer.positionStream,
                builder: (context, snapshot) {
                  return ProgressBar(
                    progress: snapshot.data ?? const Duration(seconds: 0),
                    total: audioState.audioPlayer.duration ?? const Duration(seconds: 2),
                    buffered: audioState.audioPlayer.bufferedPosition,
                    onSeek: (duration) {
                      ref.read(audioPlayerViewModelProvider.notifier).skipForwardPosition(duration);
                    },
                  );
                }
              ),
            ),
            TextButton(
                onPressed: () {
                  final songName = '신호등';
                  final artist = '이무진';
                  ref
                      .read(audioPlayerViewModelProvider.notifier)
                      .setAudioPlayer(songName, artist);
                },
                child: Text('이무진 - 신호등')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      ref
                          .read(audioPlayerViewModelProvider.notifier)
                          .togglePlay();
                    },
                    icon: Icon(Icons.play_arrow)),
                IconButton(
                    onPressed: () {
                      ref
                          .read(audioPlayerViewModelProvider.notifier)
                          .togglePause();
                    },
                    icon: Icon(Icons.pause)),
                IconButton(
                    onPressed: () {
                      ref
                          .read(audioPlayerViewModelProvider.notifier)
                          .skipForwardSec(10);
                    },
                    icon: Icon(Icons.skip_next)),
              ],
            ),
          ],
        );
      },
    );
  }
  */

  Widget bottomAudioPlayer() {
    return Consumer(
      builder: (context, ref, child) {
        final audioState = ref.watch(audioPlayerViewModelProvider);
        if(audioState.playerStateSubscription == null){
          return SizedBox.shrink();
        }
        return Container(
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 50,
                height: 50,
                color: Colors.red,
              ),
              IconButton(
                  onPressed: () {
                    ref
                        .read(audioPlayerViewModelProvider.notifier)
                        .togglePlay();
                  },
                  icon: Icon(Icons.play_arrow)),
              IconButton(
                  onPressed: () {
                    ref
                        .read(audioPlayerViewModelProvider.notifier)
                        .togglePause();
                  },
                  icon: Icon(Icons.pause)),
              IconButton(
                  onPressed: () {
                    ref
                        .read(audioPlayerViewModelProvider.notifier)
                        .skipForwardSec(10);
                  },
                  icon: Icon(Icons.skip_next)),
            ],
          ),
        );
      },
    );
  }
}

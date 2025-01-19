import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({super.key, required this.isMainWidget});

  final bool isMainWidget;

  @override
  Widget build(BuildContext context) {
    return isMainWidget ? fullAudioPlayer() : bottomAudioPlayer();
  }

  Widget fullAudioPlayer() {
    return Consumer(
      builder: (context, ref, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    icon: Icon(Icons.stop)),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget bottomAudioPlayer() {
    return Container();
  }
}

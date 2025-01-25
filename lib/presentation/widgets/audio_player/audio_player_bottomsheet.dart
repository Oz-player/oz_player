import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/condition_view_model.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AudioBottomSheet {
  static void show(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final audioState = ref.watch(audioPlayerViewModelProvider);
            final conditionState = ref.watch(conditionViewModelProvider);

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xffa86cd9)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Wrap(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                        width: double.maxFinite,
                      ),
                      Container(
                        height: 5,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      ToggleSwitch(
                        minWidth: 90,
                        cornerRadius: 8,
                        activeBgColors: [
                          [Colors.green[800]!],
                          [Colors.red[800]!]
                        ],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        initialLabelIndex: 0,
                        totalSwitches: 2,
                        labels: ['노래', '동영상'],
                        radiusStyle: true,
                        onToggle: (index) {
                          print('switched to: $index');
                        },
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(12)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            conditionState.recommendSongs[index].imgUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/muoz.png',
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      AutoSizeText(
                        conditionState.recommendSongs[index].title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      AutoSizeText(
                        conditionState.recommendSongs[index].artist,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: StreamBuilder(
                            stream: audioState.audioPlayer.positionStream,
                            builder: (context, snapshot) {
                              return ProgressBar(
                                progress:
                                    snapshot.data ?? const Duration(seconds: 0),
                                total: audioState.audioPlayer.duration ??
                                    const Duration(seconds: 0),
                                buffered:
                                    audioState.audioPlayer.bufferedPosition,
                                timeLabelTextStyle:
                                    TextStyle(color: Colors.white),
                                timeLabelPadding: 10,
                                baseBarColor: Color(0xff40017e),
                                progressBarColor: Colors.white,
                                //bufferedBarColor: Colors.grey,
                                thumbColor: Colors.white,
                                onSeek: (duration) {
                                  ref
                                      .read(
                                          audioPlayerViewModelProvider.notifier)
                                      .skipForwardPosition(duration);
                                },
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                ref
                                    .read(audioPlayerViewModelProvider.notifier)
                                    .skipBackwardSec(10);
                              },
                              child: Icon(
                                Icons.skip_previous,
                                size: 28,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 40,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
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
                            child: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(50)),
                              child: CircleAvatar(
                                backgroundColor: Colors.white30,
                                child: Icon(
                                  audioState.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                ref
                                    .read(audioPlayerViewModelProvider.notifier)
                                    .skipForwardSec(10);
                              },
                              child: Icon(
                                Icons.skip_next,
                                size: 28,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 64,
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

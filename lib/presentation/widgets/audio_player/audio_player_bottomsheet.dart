import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/app/logic/isvaildurl.dart';
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
                  color: Colors.white),
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
                        minWidth: 67,
                        cornerRadius: 8,
                        activeBgColors: [
                          [Color(0xff7303E3)],
                          [Color(0xff7303E3)]
                        ],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        initialLabelIndex: 0,
                        totalSwitches: 2,
                        labels: ['노래', '동영상'],
                        customTextStyles: [],
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
                          child: audioState.loadingAudio
                              ? Center(child: CircularProgressIndicator())
                              : isValidUrl(conditionState
                                      .recommendSongs[index].imgUrl)
                                  ? Image.network(
                                      conditionState
                                          .recommendSongs[index].imgUrl,
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
                        height: 12,
                      ),
                      AutoSizeText(
                        audioState.loadingAudio ? '음악 로딩중' : conditionState.recommendSongs[index].title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      AutoSizeText(
                        audioState.loadingAudio ? '잠시만 기다려주세요' : conditionState.recommendSongs[index].artist,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        minFontSize: 12,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
                                    TextStyle(color: Color(0xff7303E3)),
                                timeLabelPadding: 10,
                                baseBarColor: Color(0xffF2E6FF),
                                progressBarColor: Color(0xff7303E3),
                                bufferedBarColor: Color(0xffD9B3FE),
                                thumbColor: Color(0xff7303E3),
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
                              child: Image.asset(
                                  'assets/images/skip_backward_icon.png')),
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
                                  borderRadius: BorderRadius.circular(50)),
                              child: CircleAvatar(
                                backgroundColor: Color(0xffF2E6FF),
                                child: Icon(
                                  audioState.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 28,
                                  color: Color(0xff7303E3),
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
                              child: Image.asset(
                                  'assets/images/skip_forward_icon.png')),
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

  static void showCurrentAudio(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final audioState = ref.watch(audioPlayerViewModelProvider);
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                  color: Colors.white),
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
                        minWidth: 67,
                        cornerRadius: 8,
                        activeBgColors: [
                          [Color(0xff7303E3)],
                          [Color(0xff7303E3)]
                        ],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        initialLabelIndex: 0,
                        totalSwitches: 2,
                        labels: ['노래', '동영상'],
                        customTextStyles: [],
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
                        height: 12,
                      ),
                      AutoSizeText(
                        audioState.loadingAudio ? '음악 로딩중' : audioState.currentSong!.title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        minFontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      AutoSizeText(
                        audioState.loadingAudio ? '잠시만 기다려주세요' : audioState.currentSong!.artist,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        minFontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
                                    TextStyle(color: Color(0xff7303E3)),
                                timeLabelPadding: 10,
                                baseBarColor: Color(0xffF2E6FF),
                                progressBarColor: Color(0xff7303E3),
                                bufferedBarColor: Color(0xffD9B3FE),
                                thumbColor: Color(0xff7303E3),
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
                              child: Image.asset(
                                  'assets/images/skip_backward_icon.png')),
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
                                  borderRadius: BorderRadius.circular(50)),
                              child: CircleAvatar(
                                backgroundColor: Color(0xffF2E6FF),
                                child: Icon(
                                  audioState.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 28,
                                  color: Color(0xff7303E3),
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
                              child: Image.asset(
                                  'assets/images/skip_forward_icon.png')),
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

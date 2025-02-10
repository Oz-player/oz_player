import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/providers/login/providers.dart';
import 'package:oz_player/presentation/ui/ranking_page/view_model/ranking_view_model.dart';
import 'package:oz_player/presentation/ui/ranking_page/widgets/speech_bubble_widget.dart';
import 'package:oz_player/presentation/ui/saved/widgets/saved_tab_button.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_bottomsheet.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';
import 'package:oz_player/presentation/widgets/speech_ballon/speech_ballon.dart';

class RankingPage extends ConsumerStatefulWidget {
  const RankingPage({super.key});

  @override
  ConsumerState<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends ConsumerState<RankingPage> {
  bool isLibrary = true;

  void onButtonClicked() {
    setState(() {
      isLibrary = !isLibrary;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rankingState = ref.watch(rankingViewModelProvider);

    return rankingState.when(
        loading: () => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/background.png'),
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        error: (err, stack) => Container(),
        data: (data) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.png'),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(
                  '뮤의 음악 랭킹',
                  style: TextStyle(color: Colors.grey[900], fontSize: 18),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
              ),
              body: SafeArea(
                  child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: Color(0xffA54DFD),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Positioned(
                              top: 35,
                              left: 24,
                              child: Text(
                                '가장 인기있는 TOP3를\n소개한다냥',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(8)),
                                    child:
                                        Image.asset('assets/char/myu_2.png'))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                SavedTabButton(
                                  title: '플레이리스트 추가 순',
                                  isLibrary: isLibrary,
                                  onClicked: onButtonClicked,
                                ),
                                SavedTabButton(
                                  title: '카드 저장 순',
                                  isLibrary: !isLibrary,
                                  onClicked: onButtonClicked,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                                left: 0,
                                right: 0,
                                bottom: -96,
                                child: Image.asset(
                                  'assets/images/ranking_background.png',
                                  fit: BoxFit.fill,
                                )),
                            Positioned(
                                right: 30,
                                bottom: 70,
                                child: Image.asset(
                                    'assets/images/ranking_myu.png')),
                            Positioned(
                                left: 0,
                                right: 0,
                                bottom: 144,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Image.asset(
                                          'assets/images/ranking_shadow.png'),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                // 2위 클릭
                                                ref
                                                    .read(
                                                        rankingViewModelProvider
                                                            .notifier)
                                                    .changeFocusIndex(
                                                        FocusIndex.secondPrice);
                                              },
                                              child: data.focusIndex ==
                                                      FocusIndex.secondPrice
                                                  ? Image.asset(
                                                      'assets/images/prize_two_0.png')
                                                  : Image.asset(
                                                      'assets/images/prize_two_1.png'),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                // 1위 클릭
                                                ref
                                                    .read(
                                                        rankingViewModelProvider
                                                            .notifier)
                                                    .changeFocusIndex(
                                                        FocusIndex.firstPrice);
                                              },
                                              child: data.focusIndex ==
                                                      FocusIndex.firstPrice
                                                  ? Image.asset(
                                                      'assets/images/prize_one_0.png')
                                                  : Image.asset(
                                                      'assets/images/prize_one_1.png'),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                // 3위 클릭
                                                ref
                                                    .read(
                                                        rankingViewModelProvider
                                                            .notifier)
                                                    .changeFocusIndex(
                                                        FocusIndex.thirdPrice);
                                              },
                                              child: data.focusIndex ==
                                                      FocusIndex.thirdPrice
                                                  ? Image.asset(
                                                      'assets/images/prize_three_0.png')
                                                  : Image.asset(
                                                      'assets/images/prize_three_1.png'),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16,
                                        )
                                      ],
                                    ),
                                    if (data.focusIndex ==
                                        FocusIndex.firstPrice)
                                      Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 160,
                                          child: isLibrary
                                              ? SpeechBubbleWidget(
                                                  song: data.cardRanking[0])
                                              : SpeechBubbleWidget(
                                                  song:
                                                      data.playlistRanking[0])),
                                    if (data.focusIndex ==
                                        FocusIndex.secondPrice)
                                      Positioned(
                                          left: 0,
                                          right: 50,
                                          bottom: 160,
                                          child: SpeechBubbleWidget(
                                            nipLocation: NipLocation.bottomLeft,
                                          )),
                                    if (data.focusIndex ==
                                        FocusIndex.thirdPrice)
                                      Positioned(
                                          left: 50,
                                          right: 0,
                                          bottom: 160,
                                          child: SpeechBubbleWidget(
                                            nipLocation:
                                                NipLocation.bottomRight,
                                          )),
                                  ],
                                )),
                            Positioned(
                                right: 0,
                                left: 180,
                                bottom: 160,
                                top: 0,
                                child: InkWell(
                                  onTap: () async {
                                    RawSongEntity? song;

                                    if (isLibrary) {
                                      if (data.focusIndex ==
                                          FocusIndex.firstPrice) {
                                        song = data.cardRanking[0];
                                      } else if (data.focusIndex ==
                                          FocusIndex.secondPrice) {
                                        song = data.cardRanking[1];
                                      } else if (data.focusIndex ==
                                          FocusIndex.thirdPrice) {
                                        song = data.cardRanking[2];
                                      }
                                    } else {
                                      if (data.focusIndex ==
                                          FocusIndex.firstPrice) {
                                        song = data.playlistRanking[0];
                                      } else if (data.focusIndex ==
                                          FocusIndex.secondPrice) {
                                        song = data.playlistRanking[1];
                                      } else if (data.focusIndex ==
                                          FocusIndex.thirdPrice) {
                                        song = data.playlistRanking[2];
                                      }
                                    }

                                    AudioBottomSheet.showCurrentAudio(context);

                                    ref
                                        .read(audioPlayerViewModelProvider
                                            .notifier)
                                        .isStartLoadingAudioPlayer();

                                    SongEntity playSong = SongEntity(
                                        video: song!.video,
                                        title: song.title,
                                        imgUrl: song.imgUrl,
                                        artist: song.artist,
                                        mood: '',
                                        situation: '',
                                        genre: '',
                                        favoriteArtist: '');

                                    ref
                                        .read(audioPlayerViewModelProvider
                                            .notifier)
                                        .setCurrentSong(playSong);

                                    await ref
                                        .read(audioPlayerViewModelProvider
                                            .notifier)
                                        .setAudioPlayer(
                                            playSong.video.audioUrl, -2);
                                  },
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 24,
                    child: AudioPlayer(
                      colorMode: true,
                    ),
                  ),
                ],
              )),
              bottomNavigationBar: HomeBottomNavigation(),
            ),
          );
        });
  }
}

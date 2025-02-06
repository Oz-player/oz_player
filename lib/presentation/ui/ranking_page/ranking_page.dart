import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/ranking_page/widgets/speech_bubble_widget.dart';
import 'package:oz_player/presentation/ui/saved/widgets/saved_tab_button.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

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
                              child: Image.asset('assets/char/myu_2.png'))),
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
                          bottom: 80,
                          child: Image.asset('assets/images/ranking_myu.png')),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 164,
                          child: Stack(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                          'assets/images/prize_two_1.png'),
                                      Image.asset(
                                          'assets/images/prize_one_0.png'),
                                      Image.asset(
                                          'assets/images/prize_three_1.png'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  )
                                ],
                              ),
                            ],
                          )),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 260,
                          child: SpeechBubbleWidget()),
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
  }
}

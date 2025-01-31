import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                          '다른 사용자들이 좋아하는\n음악들을 모아봤다냥',
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
                isLibrary
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: Text('$index')),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: 56,
                                      height: 56,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 18,
                                    ),
                                    Column(
                                      children: [Text('음악제목'), Text('가수이름')],
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        print('tap');
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        color: Colors.transparent,
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Colors.grey[300],
                                          ),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              itemCount: 10),
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: Text('$index')),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: 56,
                                      height: 56,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 18,
                                    ),
                                    Column(
                                      children: [Text('음악제목'), Text('가수이름')],
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        print('tap');
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        color: Colors.transparent,
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Colors.grey[300],
                                          ),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              itemCount: 10),
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

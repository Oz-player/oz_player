import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';
import 'package:oz_player/presentation/widgets/home_tap/bottom_navigation_view_model/bottom_navigation_view_model.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bottomNavigationProvider.notifier).resetPage();
    });

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
          title: SizedBox(
              width: 96,
              height: 28,
              child: SvgPicture.asset('assets/svg/muoz.svg')),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            // 설정창
            Semantics(
              label: '설정 버튼',
              child: IconButton(
                  onPressed: () {
                    context.push('/settings');
                  },
                  icon: SvgPicture.asset(
                    'assets/svg/option_icon.svg',
                    semanticsLabel: '',
                  )),
            ),
            SizedBox(
              width: 8,
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color(0xffA54DFD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Positioned(
                      top: 32,
                      left: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '오즈의 음악 카드',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '마법사 오즈가 추천하는 신비로운 음악 카드',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 25,
                        left: 24,
                        child: SizedBox(
                          width: 100,
                          height: 36,
                          child: TextButton(
                            onPressed: () {
                              ref
                                  .read(bottomNavigationProvider.notifier)
                                  .updatePage(4);
                              context.go('/home/recommend');
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xff5902B0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: Text(
                              '추천받기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        )),
                    Positioned(
                        bottom: 6,
                        right: 2,
                        child: SvgPicture.asset('assets/svg/oz_3.svg')),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[400]!)),
                    ),
                    Positioned(
                      top: 32,
                      left: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '뮤의 음악 랭킹',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '고양이 뮤가 소개하는 인기 음악 순위',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 25,
                        left: 24,
                        child: SizedBox(
                          width: 100,
                          height: 36,
                          child: TextButton(
                            onPressed: () {
                              context.go('/home/ranking');
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xff5902B0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: Text(
                              '둘러보기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        )),
                    Positioned(
                        bottom: 0,
                        right: 18,
                        child: SvgPicture.asset('assets/svg/myu_1.svg')),
                  ],
                ),
              ),
              Spacer(),
              AudioPlayer(
                colorMode: true,
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
        bottomNavigationBar: HomeBottomNavigation(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/recommend_page/widgets/recommend_exit_alert_dialog.dart';
import 'package:oz_player/presentation/ui/saved/widgets/delete_alert_dialog.dart';
import 'package:oz_player/presentation/widgets/home_tap/bottom_navigation_view_model/bottom_navigation_view_model.dart';

// Page 목록
// { 0: saved, 1: home, 2: search, 4: recommend, 5: edit}

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final currentPage = ref.watch(bottomNavigationProvider);
      return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: SizedBox(
            height: 108,
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              currentIndex: currentPage == 4
                  ? 1
                  : currentPage == 5
                      ? 0
                      : currentPage,
              elevation: 10,
              unselectedItemColor: Colors.grey[600],
              selectedItemColor: Color(0xff7303e3),
              onTap: (value) {
                switch (value) {
                  // 보관함 탭을 터치했을 경우
                  case 0:
                    // 특이케이스 : 선택지 플로우에서 이탈시
                    if (currentPage == 4) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => RecommendExitAlertDialog(
                          destination: 0,
                        ),
                      );
                      break;
                    }

                    // 특이케이스 : 선택지 플로우에서 이탈시
                    if (currentPage == 5) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => CancleEditAlertDialog(
                          destination: 1,
                        ),
                      );
                      break;
                    }

                    if (currentPage != 0 && currentPage != 4) {
                      context.go('/saved');
                      ref
                          .read(bottomNavigationProvider.notifier)
                          .updatePage(value);
                    }
                    break;

                  // 홈 탭을 터치했을 경우
                  case 1:
                    // 특이케이스 : 선택지 플로우에서 이탈시
                    if (currentPage == 4) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => RecommendExitAlertDialog(
                          destination: 1,
                        ),
                      );
                      break;
                    }

                    // 특이케이스 : 플레이리스트 편집 중 이탈시
                    if (currentPage == 5) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => CancleEditAlertDialog(
                          destination: 1,
                        ),
                      );
                      break;
                    }

                    if (currentPage != 1 && currentPage != 4) {
                      context.go('/home');
                      ref
                          .read(bottomNavigationProvider.notifier)
                          .updatePage(value);
                    }
                    break;

                  // 음악 검색 탭을 터치했을 경우
                  case 2:
                    // 특이케이스 : 선택지 플로우에서 이탈시
                    if (currentPage == 4) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => RecommendExitAlertDialog(
                          destination: 2,
                        ),
                      );
                      break;
                    }

                    // 특이케이스 : 플레이리스트 편집 중 이탈시
                    if (currentPage == 5) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => CancleEditAlertDialog(
                          destination: 2,
                        ),
                      );
                      break;
                    }

                    if (currentPage != 2 && currentPage != 4) {
                      context.go('/search');
                      ref
                          .read(bottomNavigationProvider.notifier)
                          .updatePage(value);
                    }
                    break;
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(currentPage == 0 || currentPage == 5
                      ? 'assets/svg/save_icon2.svg'
                      : 'assets/svg/save_icon.svg'),
                  label: '보관함',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset((currentPage == 1 || currentPage == 4)
                      ? 'assets/svg/home_icon2.svg'
                      : 'assets/svg/home_icon.svg'),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(currentPage == 2
                      ? 'assets/svg/search_icon2.svg'
                      : 'assets/svg/search_icon.svg'),
                  label: '검색',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

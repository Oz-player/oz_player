import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/recommend_page/widgets/recommend_exit_alert_dialog.dart';
import 'package:oz_player/presentation/widgets/home_tap/bottom_navigation_view_model/bottom_navigation_view_model.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  // 향후 IOS 버전 BottomNavigationBar을 추가해야 할듯
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final currentPage = ref.watch(bottomNavigationProvider);
      return Container(
        height: 94,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BottomNavigationBar(
            currentIndex: currentPage != 4 ? currentPage : 1,
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
                      builder: (context) => RecommendExitAlertDialog(destination: 0,),
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
                      builder: (context) => RecommendExitAlertDialog(destination: 1,),
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
                      builder: (context) => RecommendExitAlertDialog(destination: 2,),
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
                icon: Icon(
                  Icons.group_work_outlined,
                ),
                label: '보관함',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: '음악 검색',
              ),
            ],
          ),
        ),
      );
    });
  }
}

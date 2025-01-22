import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/widgets/home_tap/bottom_navigation_view_model/bottom_navigation_view_model.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Hero(
        tag: 'bottomNavigationBar',
        child: BottomNavigationBar(
          currentIndex: ref.watch(bottomNavigationProvider),
          onTap: (value) {
            switch (value) {
              case 0:
                // context.go('');
                break;
              case 1:
                context.go('/home');
                break;
              case 2:
                context.go('/search');
                break;
            }
            ref.read(bottomNavigationProvider.notifier).updatePage(value);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.group_work_outlined), label: '보관함'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '음악 검색'),
          ],
        ),
      );
    });
  }
}

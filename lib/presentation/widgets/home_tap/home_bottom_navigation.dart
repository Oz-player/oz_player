import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/widgets/home_tap/bottom_navigation_view_model/bottom_navigation_view_model.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final currentPage = ref.watch(bottomNavigationProvider);
      return Hero(
        tag: 'bottomNavigationBar',
        child: Container(
          height: 94,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, -4),
            )
          ]),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: BottomNavigationBar(
              currentIndex: currentPage,
              iconSize: 28,
              elevation: 10,
              unselectedItemColor: Colors.grey[600],
              selectedItemColor: Color(0xff7303e3),
              onTap: (value) {
                switch (value) {
                  case 0:
                    if (currentPage != 0) {
                      context.go('/saved');
                    }
                    break;
                  case 1:
                    if (currentPage != 1) {
                      context.go('/home');
                    }
                    break;
                  case 2:
                    if (currentPage != 2) {
                      context.go('/search');
                    }
                    break;
                }

                ref.read(bottomNavigationProvider.notifier).updatePage(value);
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
                    label: '홈'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                    ),
                    label: '음악 검색'),
              ],
            ),
          ),
        ),
      );
    });
  }
}

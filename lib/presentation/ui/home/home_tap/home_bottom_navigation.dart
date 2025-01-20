import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/home/home_tap/home_view_model.dart';

class HomeBottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<HomeBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final currentIndex = ref.watch(homeViewModel);
      final viewModel = ref.read(homeViewModel.notifier);
      return BottomNavigationBar(
        backgroundColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: viewModel.onIndexChanged,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Icon(Icons.person),
            ),
            label: '피드',
          ),
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Icon(Icons.house),
              ),
              label: '홈'),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Icon(Icons.square),
            ),
            label: '보관',
          ),
        ],
      );
    });
  }
}

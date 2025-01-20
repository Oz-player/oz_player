

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/home/home_tap/home_view_model.dart';

class HomeIndexedStack extends StatelessWidget {
  const HomeIndexedStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(homeViewModel);
        return IndexedStack(
          index: currentIndex,
          children: [
            // TODO 여기에 탭에 속한 페이지 넣기!
          ],
        );
      }
    );
  }
}
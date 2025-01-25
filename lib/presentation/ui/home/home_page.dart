import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';
import 'package:oz_player/presentation/widgets/home_tap/bottom_navigation_view_model/bottom_navigation_view_model.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  ref.read(bottomNavigationProvider.notifier).updatePage(4);
                  context.go('/home/recommend');
                },
                child: Text('data')),
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
    );
  }
}

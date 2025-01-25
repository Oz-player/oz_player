import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  context.go('/home/recommend');
                },
                child: Text('data')),
            Spacer(),
            AudioPlayer(colorMode: true,),
            SizedBox(height: 24,),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavigation(),
    );
  }
}

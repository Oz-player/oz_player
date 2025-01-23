import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';

class Testpage extends StatelessWidget {
  const Testpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Center(
            child: TextButton(onPressed: (){
              context.go('/test/audio');
            }, child: Text('오디오페이지로')),
          ),
          AudioPlayer(isMainWidget: false)
        ],
      )),
    );
  }
}

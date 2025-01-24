import 'package:flutter/material.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: AudioPlayer()),
    );
  }
}

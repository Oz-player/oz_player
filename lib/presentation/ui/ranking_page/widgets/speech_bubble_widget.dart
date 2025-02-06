import 'package:flutter/material.dart';
import 'package:oz_player/presentation/widgets/speech_ballon/speech_ballon.dart';

class SpeechBubbleWidget extends StatelessWidget {
  const SpeechBubbleWidget({super.key, this.imgUrl, this.title, this.artist});

  final String? imgUrl;
  final String? title;
  final String? artist;

  @override
  Widget build(BuildContext context) {
    if (imgUrl == null || title == null || artist == null) {
      return SpeechBalloon(
          borderRadius: 8,
          nipHeight: 20,
          color: Colors.black.withValues(alpha: 0.32),
          width: 230,
          height: 120,
          child: Center(
              child: Text(
            '랭킹 확인 중입니다',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          )));
    }
    return SpeechBalloon(
        child: Row(
      children: [],
    ));
  }
}

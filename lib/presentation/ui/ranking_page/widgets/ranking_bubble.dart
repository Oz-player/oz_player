import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/ranking_page/view_model/ranking_view_model.dart';
import 'package:oz_player/presentation/ui/ranking_page/widgets/speech_bubble_widget.dart';
import 'package:oz_player/presentation/widgets/speech_ballon/speech_ballon.dart';

class RankingBubble extends StatelessWidget {
  const RankingBubble({super.key, required this.data, required this.isLibrary});

  final RankingState data;
  final bool isLibrary;

  @override
  Widget build(BuildContext context) {
    final List nipLocationList = [null, NipLocation.bottomLeft, NipLocation.bottomRight];
    final index = data.focusIndex.index;

    return SpeechBubbleWidget(
      nipLocation: nipLocationList[index],
      song: isLibrary ? data.cardRanking[index] : data.playlistRanking[index],
      data
    );
  }
}
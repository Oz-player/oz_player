import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/saved/widgets/saved_tab_button.dart';

class RankingSwitch extends StatelessWidget {
  const RankingSwitch(
      {super.key, required this.isLibrary, required this.onButtonClicked});

  final bool isLibrary;
  final VoidCallback onButtonClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Row(
            children: [
              SavedTabButton(
                title: '플레이리스트 추가 순',
                isLibrary: isLibrary,
                onClicked: onButtonClicked,
              ),
              SavedTabButton(
                title: '카드 저장 순',
                isLibrary: !isLibrary,
                onClicked: onButtonClicked,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.main100,
      ),
      child: Icon(
        Icons.play_arrow,
        size: 44,
        color: AppColors.main600,
      ),
    );
  }
}

class PlayButtonDisabled extends StatelessWidget {
  const PlayButtonDisabled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.gray300,
      ),
      child: Icon(
        Icons.play_arrow,
        size: 44,
        color: AppColors.gray400,
      ),
    );
  }
}

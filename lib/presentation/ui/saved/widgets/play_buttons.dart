import 'package:flutter/material.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';

// 플레이리스트 페이지 재생 버튼
class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.main400,
      ),
      child: Icon(
        Icons.play_arrow,
        size: 36,
        color: Colors.white,
      ),
    );
  }
}

// 재생 불가능 시 비활성된 재생버튼
class PlayButtonDisabled extends StatelessWidget {
  const PlayButtonDisabled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.gray300,
      ),
      child: Icon(
        Icons.play_arrow,
        size: 36,
        color: AppColors.gray400,
      ),
    );
  }
}

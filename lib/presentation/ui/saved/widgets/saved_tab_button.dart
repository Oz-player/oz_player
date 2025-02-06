import 'package:flutter/material.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';

// 보관함 라이브러리 - 플레이리스트 간 전환 버튼
class SavedTabButton extends StatelessWidget {
  const SavedTabButton({
    super.key,
    required this.title,
    required this.isLibrary,
    required this.onClicked,
  });

  final void Function() onClicked;
  final String title;
  final bool isLibrary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: !isLibrary
              ? BorderSide(
                  color: AppColors.border,
                  width: 1,
                )
              : null,
          backgroundColor: isLibrary ? AppColors.main800 : Colors.white,
        ),
        onPressed: !isLibrary ? onClicked : () {},
        child: Text(
          title,
          style: TextStyle(
            color: isLibrary ? Colors.white : AppColors.gray600,
          ),
        ),
      ),
    );
  }
}

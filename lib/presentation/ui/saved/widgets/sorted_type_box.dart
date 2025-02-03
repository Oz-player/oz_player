import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/view_models/list_sort_viewmodel.dart';

// 보관함 요소 정렬 방법 상태 관리
class SortedTypeBox extends StatelessWidget {
  const SortedTypeBox({
    super.key,
    required this.ref,
    required this.isOverlayOn,
    required this.setOverlayOn,
  });

  final WidgetRef ref;
  final bool isOverlayOn;
  final void Function() setOverlayOn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.main100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              ref.watch(listSortViewModelProvider).stateString,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            GestureDetector(
              onTap: setOverlayOn,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: Icon(
                  !isOverlayOn
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: AppColors.main600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

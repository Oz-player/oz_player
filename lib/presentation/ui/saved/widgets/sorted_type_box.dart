import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/pages/playlist_page.dart';
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
            Semantics(
              button: true,
              label: isOverlayOn ? '선택 창 닫기' : '정렬 방법 선택',
              hint: isOverlayOn ? '' : '최근 저장 순 또는 가나다 순',
              child: GestureDetector(
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
            ),
          ],
        ),
      ),
    );
  }
}

class SortedTypeOverlay extends StatelessWidget {
  const SortedTypeOverlay({
    super.key,
    required this.isOverlayOn,
    required this.widget,
    required this.whenAscending,
    required this.whenLatest,
  });

  final bool isOverlayOn;
  final MainScaffold widget;
  final void Function() whenAscending;
  final void Function() whenLatest;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 430,
      left: 20,
      child: SizedBox(
        width: 110,
        child: isOverlayOn
            ? Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => whenLatest(),
                      child: Container(
                          width: 100,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          color: widget.ref.watch(listSortViewModelProvider) ==
                                  SortedType.latest
                              ? AppColors.main100
                              : Colors.white,
                          child: Text(
                            '최근 저장 순',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color:
                                  widget.ref.watch(listSortViewModelProvider) ==
                                          SortedType.latest
                                      ? AppColors.main600
                                      : AppColors.gray600,
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        whenAscending();
                      },
                      child: Container(
                          width: 100,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          color: widget.ref.watch(listSortViewModelProvider) ==
                                  SortedType.ascending
                              ? AppColors.main100
                              : Colors.white,
                          child: Text(
                            '가나다순',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color:
                                  widget.ref.watch(listSortViewModelProvider) ==
                                          SortedType.ascending
                                      ? AppColors.main600
                                      : AppColors.gray600,
                            ),
                          )),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}

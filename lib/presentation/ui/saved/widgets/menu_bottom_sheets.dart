import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';

// 보관함 페이지 전체에서 bottomsheet로 사용하는 위젯
// 현재는 메뉴 아이템이 2개 또는 3개인 경우에만 최적화하여 구현함

class SavedMenuBottomSheet extends StatelessWidget {
  const SavedMenuBottomSheet({
    super.key,
    required this.imgUrl,
    required this.name,
    required this.items,
  });

  final String? imgUrl;
  final String name;
  final List<GestureDetector> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: items.length == 3 ? 300 : 248,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  // --------------------------------
                  // bottomsheet
                  // --------------------------------
                  // --------------------------------
                  // bottomSheet : 1. 플레이리스트 대표 이미지
                  // --------------------------------
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: imgUrl == null
                          ? DecorationImage(
                              image: AssetImage('assets/images/muoz.png'),
                            )
                          : DecorationImage(
                              image: NetworkImage(imgUrl!),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  // --------------------------------
                  // bottomSheet : 2. 노래 제목
                  // --------------------------------
                  Expanded(
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // --------------------------------
                  // bottomSheet : 3. 종료 버튼
                  // --------------------------------
                  Semantics(
                    label: '메뉴 종료',
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 48,
                        height: 48,
                        color: Colors.transparent,
                        child: Icon(Icons.close),
                      ),
                    ),
                  )
                ],
              ),
              // -------------------
              // 세부 메뉴
              // -------------------
              const SizedBox(
                height: 24,
              ),
              items[0],
              const SizedBox(
                height: 8,
              ),
              items[1],
              if (items.length == 3)
                const SizedBox(
                  height: 8,
                ),
              if (items.length == 3) items[2],
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------
// bottomSheet 내 메뉴 버튼 위젯
// ---------------------------------------
class BottomSheetMenuButton extends StatelessWidget {
  final String title;

  const BottomSheetMenuButton({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      width: double.infinity,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.gray300,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}

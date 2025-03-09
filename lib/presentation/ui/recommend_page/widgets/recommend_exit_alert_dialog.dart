import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/card_position_provider.dart';
import 'package:oz_player/presentation/widgets/home_tap/bottom_navigation_view_model/bottom_navigation_view_model.dart';

class RecommendExitAlertDialog extends ConsumerWidget {
  const RecommendExitAlertDialog({super.key, this.destination});

  final int? destination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: '음악 카드 추천받기를 그만 하시겠어요?',
      child: AlertDialog(
        backgroundColor: Colors.white,
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  '음악 카드 추천받기를\n그만 하시겠어요?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  '지금까지의 기록은 저장되지 않아요',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColors.gray300),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)))),
                          onPressed: () {
                            ref
                                .read(bottomNavigationProvider.notifier)
                                .updatePage(destination!);
                            ref.read(cardPositionProvider.notifier).reset();
                            if (destination == 0) {
                              context.pop();
                              context.go('/saved');
                            } else if (destination == 1) {
                              context.pop();
                              context.go('/home');
                            } else if (destination == 2) {
                              context.pop();
                              context.go('/search');
                            }
                          },
                          child: Text(
                            '나중에 할게요',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColors.main700),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)))),
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            '이어서 할게요',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
                top: -158,
                left: 0,
                right: 0,
                child: Image.asset('assets/char/oz_2.png')),
          ],
        ),
      ),
    );
  }
}

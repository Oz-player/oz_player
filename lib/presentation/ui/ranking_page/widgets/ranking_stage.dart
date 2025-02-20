import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/ranking_page/view_model/ranking_view_model.dart';

class RankingStage extends ConsumerWidget {
  const RankingStage(this.data, {super.key});

  final RankingState data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Semantics(
          label: '2위',
          button: true,
          child: InkWell(
            onTap: () {
              // 2위 클릭
              ref
                  .read(rankingViewModelProvider.notifier)
                  .changeFocusIndex(FocusIndex.secondPrice);
            },
            child: data.focusIndex == FocusIndex.secondPrice
                ? Image.asset('assets/images/prize_two_0.png')
                : Image.asset('assets/images/prize_two_1.png'),
          ),
        ),
        Semantics(
          label: '1위',
          button: true,
          child: InkWell(
            onTap: () {
              // 1위 클릭
              ref
                  .read(rankingViewModelProvider.notifier)
                  .changeFocusIndex(FocusIndex.firstPrice);
            },
            child: data.focusIndex == FocusIndex.firstPrice
                ? Image.asset('assets/images/prize_one_0.png')
                : Image.asset('assets/images/prize_one_1.png'),
          ),
        ),
        Semantics(
          label: '3위',
          button: true,
          child: InkWell(
            onTap: () {
              // 3위 클릭
              ref
                  .read(rankingViewModelProvider.notifier)
                  .changeFocusIndex(FocusIndex.thirdPrice);
            },
            child: data.focusIndex == FocusIndex.thirdPrice
                ? Image.asset('assets/images/prize_three_0.png')
                : Image.asset('assets/images/prize_three_1.png'),
          ),
        ),
      ],
    );
  }
}

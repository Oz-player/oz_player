import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/condition_view_model.dart';

class RecommendPageConditionOne extends ConsumerWidget {
  const RecommendPageConditionOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conditionState = ref.watch(conditionViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Semantics(
            hint: '옵션을 선택한 뒤 오른쪽 하단의 다음 버튼을 눌러주세요.', child: Text('음악 카드 추천')),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Semantics(
            label: '뒤로 가기',
            button: true,
            child: IconButton(
                onPressed: () {
                  if (conditionState.page == 0) {
                    context.pop();
                  } else {
                    ref
                        .read(conditionViewModelProvider.notifier)
                        .beforePageAnimation();
                  }
                },
                icon: Icon(Icons.arrow_back))),
      ),
      body: AnimatedOpacity(
        opacity: conditionState.opacity,
        duration: Duration(milliseconds: 250),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  '(${conditionState.page + 1}/4)',
                  semanticsLabel: '4단계 중 ${conditionState.page + 1}번째',
                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  conditionState.title[conditionState.page],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  conditionState.subtitle[conditionState.page],
                  style: TextStyle(fontSize: 14, color: AppColors.main600),
                ),
                SizedBox(
                  height: 52,
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    if (conditionState.page == 0)
                      ...boxes(
                          conditionState.mood, conditionState.moodSet, ref),
                    if (conditionState.page == 1)
                      ...boxes(conditionState.situation,
                          conditionState.situationSet, ref),
                    if (conditionState.page == 2)
                      ...boxes(
                          conditionState.genre, conditionState.genreSet, ref),
                    if (conditionState.page == 3)
                      ...boxes(
                          conditionState.artist, conditionState.artistSet, ref),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                        style: TextButton.styleFrom(
                            disabledForegroundColor: Colors.grey[400],
                            disabledBackgroundColor: Colors.grey[300],
                            backgroundColor: Colors.grey[800],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: conditionState.event == false
                            ? null
                            : () async {
                                final isNextPage = ref
                                    .read(conditionViewModelProvider.notifier)
                                    .nextPage();
                                if (isNextPage) {
                                  ref
                                      .read(conditionViewModelProvider.notifier)
                                      .recommendMusic();
                                  context.go('/home/recommend/conditionTwo');
                                }
                              },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            '다음',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 52,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> boxes(List<String> condition, Set<int> set, WidgetRef ref) {
    return List.generate(condition.length, (index) {
      if (set.contains(index)) {
        return GestureDetector(
            onTap: () {
              ref
                  .read(conditionViewModelProvider.notifier)
                  .clickBox(index, set);
            },
            child: tagBox(condition[index], true, ref));
      } else {
        return GestureDetector(
            onTap: () {
              ref
                  .read(conditionViewModelProvider.notifier)
                  .clickBox(index, set);
            },
            child: tagBox(condition[index], false, ref));
      }
    });
  }

  Widget tagBox(String tag, bool clicked, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.main100),
          borderRadius: BorderRadius.circular(8),
          color: clicked ? AppColors.main100 : Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Text(
          tag,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

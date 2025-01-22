import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/condition_view_model.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class RecommendPageConditionOne extends ConsumerStatefulWidget {
  const RecommendPageConditionOne({super.key});

  @override
  ConsumerState<RecommendPageConditionOne> createState() =>
      _RecommendPageConditionOneState();
}

class _RecommendPageConditionOneState
    extends ConsumerState<RecommendPageConditionOne> {

  @override
  Widget build(BuildContext context) {
    final conditionState = ref.watch(conditionViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('음악 카드 추천'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
        ],
      ),
      body: AnimatedOpacity(
        opacity: conditionState.opacity,
        duration: Duration(milliseconds: 500),
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
                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '지금, 당신의 상태나 기분은\n어떤지 알려주세요',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  '최대 3개까지 선택이 가능해요!',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(
                  height: 52,
                ),
                Wrap(
                  children: [
                    if (conditionState.page == 0)
                      ...boxes(conditionState.mood, conditionState.moodSet),
                    if (conditionState.page == 1)
                      ...boxes(conditionState.situation,
                          conditionState.situationSet),
                    if (conditionState.page == 2)
                      ...boxes(conditionState.genre, conditionState.genreSet),
                    if (conditionState.page == 3)
                      ...boxes(conditionState.artist, conditionState.artistSet),
                  ],
                ),
                SizedBox(height: 60,),
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.black)
                      ),
                        onPressed: () {
                          ref.read(conditionViewModelProvider.notifier).nextPage();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text('다음', style: TextStyle(color: Colors.white),),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNavigation(),
    );
  }

  List<Widget> boxes(List<String> condition, Set<int> set) {
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
    return Padding(
      padding: const EdgeInsets.only(right: 12, bottom: 12),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[800]!),
            borderRadius: BorderRadius.circular(8),
            color: clicked ? Colors.grey : Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            tag,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/condition_view_model.dart';

class RecommendPageConditionOne extends ConsumerWidget {
  const RecommendPageConditionOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conditionState = ref.watch(conditionViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('음악 카드 추천'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                '(1/4)',
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
                  ...List.generate(conditionState.mood.length, (index) {
                    if (conditionState.moodSet.contains(index)) {
                      return GestureDetector(
                          onTap: () {
                            ref
                                .read(conditionViewModelProvider.notifier)
                                .clickBox(index, conditionState.moodSet);
                          },
                          child: tagBox(conditionState.mood[index], true, ref));
                    } else {
                      return GestureDetector(
                          onTap: () {
                            ref
                                .read(conditionViewModelProvider.notifier)
                                .clickBox(index, conditionState.moodSet);
                          },
                          child:
                              tagBox(conditionState.mood[index], false, ref));
                    }
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
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

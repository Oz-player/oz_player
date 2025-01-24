import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/condition_view_model.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class RecommendPageConditionOne extends ConsumerWidget {
  const RecommendPageConditionOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conditionState = ref.watch(conditionViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('음악 카드 추천'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          if(conditionState.page == 0){
            context.pop();
          } else {
            ref.read(conditionViewModelProvider.notifier).beforePageAnimation();
          }
        }, icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
        ],
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
                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  conditionState.title[conditionState.page],
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  conditionState.subtitle[conditionState.page],
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(
                  height: 52,
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    if (conditionState.page == 0)
                      ...boxes(conditionState.mood, conditionState.moodSet, ref),
                    if (conditionState.page == 1)
                      ...boxes(conditionState.situation,
                          conditionState.situationSet, ref),
                    if (conditionState.page == 2)
                      ...boxes(conditionState.genre, conditionState.genreSet, ref),
                    if (conditionState.page == 3)
                      ...boxes(conditionState.artist, conditionState.artistSet, ref),
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
                        onPressed: () async {
                          if(conditionState.event) return;

                          final isNextPage = ref.read(conditionViewModelProvider.notifier).nextPage();
                          if(isNextPage){
                            ref.read(conditionViewModelProvider.notifier).recommendMusic();
                            context.go('/home/recommend/conditionTwo');
                          }
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
          border: Border.all(color: Color(0xffe5e8eb)),
          borderRadius: BorderRadius.circular(8),
          color: clicked ? Color(0xfff2e6ff) : Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Text(
          tag,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

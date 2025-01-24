import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/condition_view_model.dart';
import 'package:oz_player/presentation/widgets/card_widget/card_widget.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';
import 'package:oz_player/presentation/widgets/loading/loading_view_model/loading_view_model.dart';
import 'package:oz_player/presentation/widgets/loading/loading_widget.dart';

class RecommendPageConditionTwo extends ConsumerStatefulWidget {
  const RecommendPageConditionTwo({super.key});

  @override
  ConsumerState<RecommendPageConditionTwo> createState() => _RecommendPageConditionTwoState();
}

class _RecommendPageConditionTwoState extends ConsumerState<RecommendPageConditionTwo> {

  @override
  Widget build(BuildContext context) {
    final conditionState = ref.watch(conditionViewModelProvider);
    final loadingState = ref.watch(loadingViewModelProvider);

    return loadingState.isLoading
        ? Stack(
            children: [
              mainScaffold(conditionState),
              LoadingWidget(),
            ],
          )
        : mainScaffold(conditionState);
  }

  Widget mainScaffold(ConditionState conditionState) {
    return Scaffold(
      appBar: AppBar(
        title: Text('음악 카드 추천'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              '당신을 위해\n준비한 마법의 음악 카드',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '원하는 카드를 저장하거나 플레이리스트에 추가해보세요',
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                tagBox(conditionState
                    .situation[conditionState.situationSet.first]),
                tagBox(conditionState.genre[conditionState.genreSet.first]),
                tagBox(conditionState.artist[conditionState.artistSet.first]),
              ],
            ),
            SizedBox(
              height: 300,
              child: Swiper(
                loop: false,
                itemBuilder: (BuildContext context, int index) {
                  return CardWidget();
                },
                itemCount: 5,
                viewportFraction: 0.5,
                scale: 0.5,
                onIndexChanged:(index) {
                  // 중앙에 온 요소 처리
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavigation(),
    );
  }

  Widget tagBox(String tag) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, bottom: 12),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Color(0xfff2e6ff)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Text(
            tag,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}

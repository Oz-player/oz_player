import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/condition_view_model.dart';
import 'package:oz_player/presentation/widgets/loading/loading_view_model/loading_view_model.dart';
import 'package:oz_player/presentation/widgets/loading/loading_widget.dart';

class RecommendPageConditionTwo extends ConsumerWidget {
  const RecommendPageConditionTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

  Widget mainScaffold(var conditionState) {
    return Scaffold(
      appBar: AppBar(
        title: Text('음악 카드 추천'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
        ],
      ),
      body: SafeArea(
        child: Text('data'),
      ),
    );
  }
}

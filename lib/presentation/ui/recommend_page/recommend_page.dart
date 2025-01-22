import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/text_box_widgets_view_model.dart';
import 'package:oz_player/presentation/ui/recommend_page/widgets/text_box_widgets.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class RecommendPage extends ConsumerWidget {
  const RecommendPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textState = ref.watch(textBoxWidgetsViewModelProvider);
    return GestureDetector(
      onTap: () {
        ref.read(textBoxWidgetsViewModelProvider.notifier).nextText();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('음악 카드 추천'),
          centerTitle: true,
          leading: SizedBox.shrink(),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Spacer(),
                TextBoxWidgets(state: textState),
                SizedBox(
                  height: 70,
                ),
                Container(
                  width: 212,
                  height: 212,
                  color: Colors.purple,
                ),
                SizedBox(
                  height: 76,
                ),
                textState.index == 1
                    ? SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 90),
                          child: TextButton(
                              onPressed: () {
                                context.go('/home/recommend/conditionOne');
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.black),
                              ),
                              child: Text('시작하기')),
                        ),
                      )
                    : SizedBox(height: 48),
                SizedBox(
                  height: 116,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: HomeBottomNavigation(),
      ),
    );
  }
}

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
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/background_2.png'),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('음악 카드 추천', style: TextStyle(color: Color(0xff0D0019))),
            centerTitle: true,
            leading: SizedBox.shrink(),
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Spacer(),
                  TextBoxWidgets(state: textState),
                  Spacer(),
                  SizedBox(
                    width: 212,
                    height: 212,
                    // color: Colors.purple,
                  ),
                  SizedBox(height: 120),
                  textState.index == 1
                      ? Stack(
                          children: [
                            SizedBox(
                              width: 218,
                              height: 56,
                              child: TextButton(
                                  onPressed: () {
                                    context.go('/home/recommend/conditionOne');
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          Colors.white30),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      )),
                                  child: Text(
                                    '시작하기',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )),
                            ),
                            Positioned(
                                right: 14,
                                bottom: 14,
                                child: Image.asset(
                                    'assets/images/button_shining.png'))
                          ],
                        )
                      : SizedBox(height: 64),
                  SizedBox(
                    height: 54,
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: HomeBottomNavigation(),
        ),
      ),
    );
  }
}

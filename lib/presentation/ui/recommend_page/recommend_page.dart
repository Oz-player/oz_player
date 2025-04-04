import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/text_box_widgets_view_model.dart';
import 'package:oz_player/presentation/ui/recommend_page/widgets/text_box_widgets.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';
import 'package:oz_player/presentation/widgets/home_tap/bottom_navigation_view_model/bottom_navigation_view_model.dart';

class RecommendPage extends ConsumerStatefulWidget {
  const RecommendPage({super.key});

  @override
  ConsumerState<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends ConsumerState<RecommendPage> {
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer(Duration(seconds: 3), () {
      if (mounted) {
        ref.read(textBoxWidgetsViewModelProvider.notifier).nextText();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textState = ref.watch(textBoxWidgetsViewModelProvider);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background_2.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('오즈의 음악 카드',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                ref.read(bottomNavigationProvider.notifier).updatePage(1);
                context.pop();
              },
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: double.infinity,
                    height: 220,
                    color: Color(0xff6C5E7F),
                  )),
              Center(
                child: Column(
                  children: [
                    Spacer(),
                    TextBoxWidgets(state: textState),
                    Spacer(),
                    Image.asset('assets/char/oz_1.png'),
                    SizedBox(height: 20),
                    Stack(
                      children: [
                        SizedBox(
                          width: 218,
                          height: 56,
                          child: TextButton(
                              onPressed: () async {
                                await ref
                                    .read(audioPlayerViewModelProvider.notifier)
                                    .toggleStop();
                                if (context.mounted) {
                                  context.go('/home/recommend/conditionOne');
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.white30),
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
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
                            child:
                                Image.asset('assets/images/button_shining.png'))
                      ],
                    ),
                    SizedBox(
                      height: 54,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

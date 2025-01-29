import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _isAnimationLoaded = false;

  void _startNavigationTimer() {
    Future.delayed(const Duration(milliseconds: 2000)).then((_) {
      if (mounted) {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background_1.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 185),
                SizedBox(
                  width: 180,
                  child: Lottie.asset('assets/animation/logo.json', onLoaded: (state) {
                    if (!_isAnimationLoaded) {
                      _isAnimationLoaded = true;
                      _startNavigationTimer();
                    }
                  }),
                ),
                SizedBox(height: 22.5),
                Text(
                  '당신만의 신비로운 음악을\n찾아보세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600, height: 1.4),
                ),
                Spacer(flex: 432),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

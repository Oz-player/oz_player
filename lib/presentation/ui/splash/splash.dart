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
    Future.delayed(const Duration(milliseconds: 3000)).then((_) {
      if (mounted) {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Lottie.asset('assets/animation/splash_1.json', fit: BoxFit.cover, onLoaded: (state) {
          if (!_isAnimationLoaded) {
            _isAnimationLoaded = true;
            _startNavigationTimer();
          }
        }),
      ),
    );
  }
}

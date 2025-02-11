import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:oz_player/domain/usecase/login/auto_login_usecase.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _isAnimationLoaded = false;

  @override
  void initState() {
    super.initState();
    _checkLoginInfo();
  }

  Future<void> _checkLoginInfo() async {
    final autoLoginUsecase = AutoLoginUsecase();
    final uid = await autoLoginUsecase.execute();

    if (mounted) {
      if (uid != null) {
        context.go('/home');
      } else {
        _startNavigationTimer();
      }
    }
  }




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

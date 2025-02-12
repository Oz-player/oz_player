import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:oz_player/domain/usecase/login/auto_login_usecase.dart';
import 'package:oz_player/presentation/ui/saved/view_models/library_view_model.dart';
import 'package:oz_player/presentation/ui/saved/view_models/list_sort_viewmodel.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_view_model.dart';
import 'package:oz_player/presentation/view_model/user_view_model.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
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
        ref.read(userViewModelProvider.notifier).setUserId(uid);
        await ref.watch(playListViewModelProvider.notifier).getPlayLists();
        await ref.watch(libraryViewModelProvider.notifier).getLibrary();
        ref.watch(listSortViewModelProvider.notifier).setLatest();

        _startNavigationTimer('/home');
      } else {
        _startNavigationTimer('/login');
      }
    }
  }

  void _startNavigationTimer(String path) {
    Future.delayed(const Duration(milliseconds: 3000)).then((_) {
      if (mounted) {
        context.go(path);
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
        child: Lottie.asset('assets/animation/splash_1.json', fit: BoxFit.cover,
            onLoaded: (state) {
          if (!_isAnimationLoaded) {
            _isAnimationLoaded = true;
            // _startNavigationTimer();
          }
        }),
      ),
    );
  }
}

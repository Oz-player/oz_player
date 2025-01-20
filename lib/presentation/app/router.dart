import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/audio_page/audio_page.dart';
import 'package:oz_player/presentation/ui/home/home_page.dart';
import 'package:oz_player/presentation/ui/splash/splash.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Splash(),
      routes: [
        GoRoute(
          path: 'audio',
          builder: (context, state) => const AudioPage(),
        ),
        GoRoute(
          path: 'home',
          builder: (context, state) => HomePage(),
        ),
      ],
    ),
  ],

  /*
  errorBuilder: (context, state) {
    return const ErrorPage();
  }
  */
);

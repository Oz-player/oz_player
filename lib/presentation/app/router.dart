import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/audio_page/audio_page.dart';
import 'package:oz_player/presentation/ui/splash/splash.dart';
import 'package:oz_player/presentation/ui/test_page/testpage.dart';

final router = GoRouter(
  initialLocation: '/test',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Splash(),
      routes: [
        GoRoute(
          path: 'test',
          builder: (context, state) => const Testpage(),
          routes: [
            GoRoute(
              path: 'audio',
              builder: (context, state) => const AudioPage(),
            ),
          ]
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

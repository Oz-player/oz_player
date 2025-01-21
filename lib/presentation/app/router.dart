import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/audio_page/audio_page.dart';
import 'package:oz_player/presentation/ui/home/home_page.dart';
import 'package:oz_player/presentation/ui/login/login_page.dart';
import 'package:oz_player/presentation/ui/search/search.dart';
import 'package:oz_player/presentation/ui/splash/splash.dart';
import 'package:oz_player/presentation/ui/test_page/testpage.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Search(),
      routes: [
        GoRoute(
            path: 'test',
            builder: (context, state) => const Testpage(),
            routes: [
              GoRoute(
                path: 'audio',
                builder: (context, state) => const AudioPage(),
              ),
            ]),
        GoRoute(
          path: 'home',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => Search(),
        )
      ],
    ),
  ],

  /*
  errorBuilder: (context, state) {
    return const ErrorPage();
  }
  */
);

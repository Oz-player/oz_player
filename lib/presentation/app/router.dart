import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/audio_page/audio_page.dart';
import 'package:oz_player/presentation/ui/home/home_page.dart';
import 'package:oz_player/presentation/ui/login/login_page.dart';
import 'package:oz_player/presentation/ui/test_page/testpage.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(),
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
      ],
    ),
  ],

  /*
  errorBuilder: (context, state) {
    return const ErrorPage();
  }
  */
);

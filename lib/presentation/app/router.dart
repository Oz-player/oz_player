import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/home/home_page.dart';
import 'package:oz_player/presentation/ui/login/login_page.dart';
import 'package:oz_player/presentation/ui/my_page/my_page.dart';
import 'package:oz_player/presentation/ui/recommend_page/recommend_page.dart';
import 'package:oz_player/presentation/ui/recommend_page/recommend_page_condition_one.dart';
import 'package:oz_player/presentation/ui/search/search.dart';
import 'package:oz_player/presentation/ui/splash/splash.dart';


final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Splash(),
      routes: [
        GoRoute(
          path: 'login',
          builder: (context, state) => LoginPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
      routes: [
        GoRoute(
          path: 'recommend',
          builder: (context, state) => RecommendPage(),
          routes: [
            GoRoute(
              path: 'conditionOne',
              builder: (context, state) => RecommendPageConditionOne(),
            )
          ]
        )
      ]
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => Search(),
    ),
    GoRoute(
      path: '/my',
      builder: (context, state) => MyPage(),
    )
  ],

  /*
  errorBuilder: (context, state) {
    return const ErrorPage();
  }
  */
);

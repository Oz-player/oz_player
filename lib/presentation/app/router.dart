import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/home/home_page.dart';
import 'package:oz_player/presentation/ui/login/login_page.dart';
import 'package:oz_player/presentation/ui/recommend_page/recommend_page.dart';
import 'package:oz_player/presentation/ui/recommend_page/recommend_page_condition_one.dart';
import 'package:oz_player/presentation/ui/recommend_page/recommend_page_condition_two.dart';
import 'package:oz_player/presentation/ui/saved/library_page.dart';
import 'package:oz_player/presentation/ui/saved/playlist_page.dart';
import 'package:oz_player/presentation/ui/saved/saved_page.dart';
import 'package:oz_player/presentation/ui/search/search.dart';
import 'package:oz_player/presentation/ui/settings_page/revoke_page.dart';
import 'package:oz_player/presentation/ui/settings_page/settings_page.dart';
import 'package:oz_player/presentation/ui/splash/splash.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/settings/revoke',
  navigatorKey: _rootNavigatorKey,
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
      path: '/saved',
      builder: (context, state) => SavedPage(),
      routes: [
        GoRoute(
          path: 'playlist',
          builder: (context, state) => PlaylistPage(),
        ),
        GoRoute(
          path: 'library',
          builder: (context, state) => LibraryPage(),
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
            ),
            GoRoute(
              path: 'conditionTwo',
              builder: (context, state) => RecommendPageConditionTwo(),
            )
          ],
        )
      ],
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => Search(),
    ),
    GoRoute(
      path: '/settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => SettingsPage(),
      routes: [
        GoRoute(
          path: 'revoke',
          builder: (context, state) => RevokePage(),
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

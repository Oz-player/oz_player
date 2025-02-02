import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/ui/home/home_page.dart';
import 'package:oz_player/presentation/ui/login/login_page.dart';
import 'package:oz_player/presentation/ui/ranking_page/ranking_page.dart';
import 'package:oz_player/presentation/ui/recommend_page/recommend_page.dart';
import 'package:oz_player/presentation/ui/recommend_page/recommend_page_condition_one.dart';
import 'package:oz_player/presentation/ui/recommend_page/recommend_page_condition_two.dart';
import 'package:oz_player/presentation/ui/saved/pages/library_page.dart';
import 'package:oz_player/presentation/ui/saved/pages/playlist_page.dart';
import 'package:oz_player/presentation/ui/saved/pages/saved_page.dart';
import 'package:oz_player/presentation/ui/saved/pages/update_playlist_page.dart';
import 'package:oz_player/presentation/ui/search/search.dart';
import 'package:oz_player/presentation/ui/settings_page/revoke_page.dart';
import 'package:oz_player/presentation/ui/settings_page/settings_page.dart';
import 'package:oz_player/presentation/ui/splash/splash.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
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
          builder: (context, state) => PlaylistPage(
            playlist: state.extra as PlayListEntity,
          ),
          routes: [
            GoRoute(
              path: 'update',
              builder: (context, state) =>
                  UpdatePlaylistPage(playlist: state.extra as PlayListEntity),
            ),
          ],
        ),
        GoRoute(
          path: 'library',
          builder: (context, state) => LibraryPage(
            library: (state.extra as List<dynamic>)[0] as List<LibraryEntity>,
            songs: (state.extra as List<dynamic>)[1] as List<SongEntity>,
          ),
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
        ),
        GoRoute(
          path: 'ranking',
          builder: (context, state) => RankingPage(),
        ),
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/presentation/ui/home/home_page.dart';
import 'package:oz_player/presentation/ui/login/login_page.dart';
import 'package:oz_player/presentation/ui/ranking_page/ranking_page.dart';
import 'package:oz_player/presentation/ui/recommend_page/recommend_page.dart';
import 'package:oz_player/presentation/ui/recommend_page/recommend_page_condition_one.dart';
import 'package:oz_player/presentation/ui/recommend_page/recommend_page_condition_two.dart';
import 'package:oz_player/presentation/ui/saved/pages/library_page.dart';
import 'package:oz_player/presentation/ui/saved/pages/playlist_page.dart';
import 'package:oz_player/presentation/ui/saved/pages/saved_page.dart';
import 'package:oz_player/presentation/ui/saved/pages/edit_playlist_page.dart';
import 'package:oz_player/presentation/ui/search/search.dart';
import 'package:oz_player/presentation/ui/search/widgets/bottomSheet/lyrics_page.dart';
import 'package:oz_player/presentation/ui/settings_page/ask_page.dart';
import 'package:oz_player/presentation/ui/settings_page/private_info_page.dart';
import 'package:oz_player/presentation/ui/settings_page/revoke_page.dart';
import 'package:oz_player/presentation/ui/settings_page/settings_page.dart';
import 'package:oz_player/presentation/ui/splash/splash.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Splash(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
      routes: [
        GoRoute(
          path: 'private',
          builder: (context, state) => PrivateInfoPage(),
        ),
      ],
    ),

    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return Scaffold(
          body: child, // 현재 선택된 페이지가 child로 들어옴
          bottomNavigationBar: HomeBottomNavigation(), // 고정된 네비게이션 바
        );
      },
      routes: [
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
                  path: 'edit',
                  builder: (context, state) =>
                      EditPlaylistPage(playlist: state.extra as PlayListEntity),
                ),
              ],
            ),
            GoRoute(
              path: 'library',
              builder: (context, state) => LibraryPage(
                library:
                    (state.extra as List<dynamic>)[0] as List<LibraryEntity>,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => Search(),
          routes: [
            GoRoute(
              path: 'lyrics',
              builder: (context, state) {
                final args = state.extra as Map<String, dynamic>;
                return LyricsPage(
                  song: args['song'],
                  artist: args['artist'],
                  lyrics: args['lyrics'],
                );
              },
            ),
          ],
        ),
      ],
    ),
    // 설정 페이지 같은 네비게이션 바 없는 페이지들은 여전히 따로 관리

    GoRoute(
      path: '/settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => SettingsPage(),
      routes: [
        GoRoute(
          path: 'revoke',
          builder: (context, state) => RevokePage(),
        ),
        GoRoute(
          path: 'ask',
          builder: (context, state) => AskPage(),
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

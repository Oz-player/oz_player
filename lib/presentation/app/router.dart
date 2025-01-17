import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/splash/splash.dart';

final router = GoRouter(
  initialLocation: '/',

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Splash(),
      // routes: [],
    ),
  ],

  /*
  errorBuilder: (context, state) {
    return const ErrorPage();
  }
  */
);
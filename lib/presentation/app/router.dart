import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/home/home_page.dart';

final router = GoRouter(
  initialLocation: '/',

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
      //routes: [],
    ),
  ],

  /*
  errorBuilder: (context, state) {
    return const ErrorPage();
  }
  */
);
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TextButton(onPressed: () {
          context.go('/home/recommend');
        }, child: Text('data')),
      ),
      bottomNavigationBar: HomeBottomNavigation(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/home/home_tap/home_bottom_navigation.dart';
import 'package:oz_player/presentation/ui/home/home_tap/home_indexed_stack.dart';

class HomeTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeIndexedStack(),
      bottomNavigationBar: HomeBottomNavigation(),
    );
  }
}

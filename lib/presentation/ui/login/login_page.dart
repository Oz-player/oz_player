import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/login/widgets/apple_button.dart';
import 'package:oz_player/presentation/ui/login/widgets/google_button.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoogleButton(),
            SizedBox(height: 12),
            AppleButton(),
          ],
        ),
      ),
    );
  }
}



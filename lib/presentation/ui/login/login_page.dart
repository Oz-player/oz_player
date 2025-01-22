import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/login/login_view_model.dart';
import 'package:oz_player/presentation/ui/login/widgets/apple_button.dart';
import 'package:oz_player/presentation/ui/login/widgets/google_button.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginViewModelProvider);

    // 로그인 상태가 success일 때, 페이지 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loginState == LoginState.success) {
        context.go('/home');
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoogleButton(),
            SizedBox(height: 12),
            AppleButton(), // IOS에서만 애플 로그인 버튼 보임
          ],
        ),
      ),
    );
  }
}

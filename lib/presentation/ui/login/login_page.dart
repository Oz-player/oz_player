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
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 166),
                SizedBox(
                  width: 164,
                  child: Image.asset('assets/images/muoz.png'),
                ),
                SizedBox(height: 28.5),
                Text(
                  '당신만의 신비로운 음악을\n찾아보세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 1.4),
                ),
                Spacer(flex: 264),
                GoogleButton(),
                AppleButton(), // IOS에서만 애플 로그인 버튼 보임
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

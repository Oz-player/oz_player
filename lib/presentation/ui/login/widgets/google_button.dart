import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/login/login_view_model.dart';

class GoogleButton extends ConsumerWidget {
  const GoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await ref.read(loginViewModelProvider.notifier).googleLogin();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('구글 로그인 실패! $e')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(335, 52),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        textStyle: TextStyle(fontSize: 18),
        minimumSize: Size.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/ic_google_logo.png',
            height: 24,
            fit: BoxFit.fitHeight,
          ),
          SizedBox(width: 4),
          Text('Google로 시작하기'),
        ],
      ),
    );
  }
}

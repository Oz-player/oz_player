import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/login/login_view_model.dart';

class AppleButton extends ConsumerWidget {
  const AppleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // IOS에서만 보이게! 안드로이드에서는 빈공간 반환
    if (!Platform.isIOS) return SizedBox();

    return ElevatedButton(
      onPressed: () async {
        try {
          await ref.read(loginViewModelProvider.notifier).appleLogin();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('애플 로그인 실패! $e')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(335, 52),
        padding: EdgeInsets.zero,
        textStyle: TextStyle(fontSize: 20, height: 24/20),
        minimumSize: Size.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/ic_apple_logo.png',
            color: Colors.white,
            height: 24,
            fit: BoxFit.fitHeight,
          ),
          SizedBox(width: 15),
          Text('Apple로 시작하기'),
        ],
      ),
    );
  }
}

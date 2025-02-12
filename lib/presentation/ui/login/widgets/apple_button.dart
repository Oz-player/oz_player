import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/login/login_view_model.dart';

class AppleButton extends ConsumerWidget {
  final bool activated;

  const AppleButton({
    super.key,
    required this.activated,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // IOS에서만 보이게! 안드로이드에서는 빈공간 반환
    if (!Platform.isIOS) return SizedBox(height: 16);

    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(64),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: activated
            ? () async {
                try {
                  await ref.read(loginViewModelProvider.notifier).appleLogin();
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('애플 로그인 실패! $e')),
                    );
                  }
                }
              }
            : () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text(
                      '안내',
                      textAlign: TextAlign.center,
                    ),
                    content: Text(
                      '개인정보 수집 및 이용에 동의해야\n 로그인을 할 수 있습니다!',
                      textAlign: TextAlign.center,
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('확인'),
                      ),
                    ],
                  ),
                );
              },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 54),
          padding: EdgeInsets.zero,
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, height: 19 / 16),
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
      ),
    );
  }
}

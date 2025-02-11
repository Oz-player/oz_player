import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/login/login_view_model.dart';

class GoogleButton extends ConsumerWidget {
  final bool activated;

  const GoogleButton({
    super.key,
    required this.activated,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(64),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Opacity(
        opacity: activated ? 1.0 : 0.8,
        child: ElevatedButton(
          onPressed: activated ? () async {
            try {
              await ref.read(loginViewModelProvider.notifier).googleLogin();
            } catch (e) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('구글 로그인 실패! $e')),
              );
            }
          } : () {},
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.infinity, 54),
            padding: EdgeInsets.zero,
            textStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, height: 19 / 16),
            minimumSize: Size.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF6B7684),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/ic_google_logo.png',
                height: 24,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(width: 15),
              Text('Google로 시작하기'),
            ],
          ),
        ),
      ),
    );
  }
}

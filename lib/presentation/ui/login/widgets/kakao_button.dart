import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KakaoButton extends ConsumerWidget {
  const KakaoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        onPressed: () async {
        // TODO
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 54),
          padding: EdgeInsets.zero,
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 19/16),
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: 	Color(0xFFFEE500),
          foregroundColor: Colors.black87,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ic_kakao_logo.png',
              color: Colors.black,
              height: 23,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(width: 12),
            Text('Kakao로 시작하기'),
          ],
        ),
      ),
    );
  }
}

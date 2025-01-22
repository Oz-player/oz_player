import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
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

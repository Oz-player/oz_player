import 'package:flutter/material.dart';

class AppleButton extends StatelessWidget {
  const AppleButton({
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
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.translate(
            offset: Offset(0, -.5),
            child: Image.asset(
              'assets/images/ic_apple_logo.png',
              color: Colors.white,
              height: 24,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(width: 6),
          Text('Apple로 시작하기'),
        ],
      ),
    );
  }
}

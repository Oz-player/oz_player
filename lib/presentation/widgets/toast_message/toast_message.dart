import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ToastMessage {
  static final position =
      StyledToastPosition(align: Alignment.bottomCenter, offset: 96);

  static void show(BuildContext context) {
    showToastWidget(
        context: context,
        position: position,
        Container(
          height: 48,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          margin: EdgeInsets.symmetric(horizontal: 24.0),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: Colors.grey[800],
          ),
          child: Row(
            children: [
              Image.asset('assets/images/check-one-filled.png'),
              SizedBox(
                width: 8,
              ),
              Text(
                '저장이 완료되었습니다.',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )
            ],
          ),
        ));
  }
}

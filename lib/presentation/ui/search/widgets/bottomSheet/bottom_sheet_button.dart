import 'package:flutter/material.dart';

Widget bottomSheetButton(
  BuildContext context,
  String text,
  VoidCallback onPressed,
) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.43),
        color: Colors.grey[300],
      ),
      width: double.infinity,
      height: 44,
      child: Text(text),
    ),
  );
}

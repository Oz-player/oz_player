import 'package:flutter/material.dart';

class TextBoxWidgets extends StatelessWidget {
  const TextBoxWidgets({super.key, required this.state});
  final dynamic state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Center(
          widthFactor: 1.0,
          child: Text(
            state.textList[state.index],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[900]),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextBoxWidgets extends StatelessWidget {
  const TextBoxWidgets({super.key, this.state});
  final state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          state.textList[state.index],
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

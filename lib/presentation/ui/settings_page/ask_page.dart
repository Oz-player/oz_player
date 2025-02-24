import 'package:flutter/material.dart';

class AskPage extends StatelessWidget {
  const AskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '문의하기',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey[900],
            height: 1.4,
          ),
        ),
      ),
      body: Center(
          child: Text(
        'uuumonazzz@gmail.com',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      )),
    );
  }
}

import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final Widget goToThePage;

  const SettingsButton({
    super.key,
    required this.text,
    required this.goToThePage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => goToThePage),
        );
      },
      child: Container(
        height: 64,
        width: double.infinity,
        color: Colors.transparent,
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7684),
                fontWeight: FontWeight.w500,
                height: 17 / 14,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Color(0xFF6B7684),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RevokeReasonButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;
  final String text;

  const RevokeReasonButton({
    super.key,
    required this.isSelected,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: isSelected ? Color(0xFFF2E6FF) : Colors.white,
            foregroundColor: isSelected ? Color(0xFF191F28) : Color(0xFF6B7684),
            side: isSelected
                ? BorderSide.none
                : BorderSide(
                    color: Color(0xFFE5E8EB),
                    width: 1,
                  ),
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF191F28), height: 1.4),
        
          ),
          child: Text(text),
        ),
      ),
    );
  }
}

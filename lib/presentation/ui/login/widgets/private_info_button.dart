import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivateInfoButton extends StatefulWidget {
  final void Function(bool) onChecked;

  const PrivateInfoButton({super.key, required this.onChecked});

  @override
  State<PrivateInfoButton> createState() => _PrivateInfoButtonState();
}

class _PrivateInfoButtonState extends State<PrivateInfoButton> {
  bool _isChecked = false;

  void _boxCheck() {
    setState(() {
      _isChecked = !_isChecked;
    });
    widget.onChecked(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _boxCheck,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: Color(0xFFEFF1F3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: _isChecked
                ? Icon(Icons.check, size: 19, color: Color(0xFF6B7684))
                : null,
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              context.go('/login/private');
            },
            child: SizedBox(
              height: 14,
              child: Text(
                '로그인 시 동의 및 개인정보 제공에 동의한 것으로 간주됩니다.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8D8D8D),
                  height: 14 / 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';

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
    SemanticsAction.tap;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _boxCheck,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Semantics(
            label: '회원 로그인에 필요한 개인정보 제공에 동의하신다면 두 번 탭해주세요',
            value: _isChecked ? '동의함' : '동의하지 않음',
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: AppColors.gray300,
                borderRadius: BorderRadius.circular(4),
              ),
              child: _isChecked
                  ? Icon(Icons.check, size: 19, color: AppColors.gray600)
                  : null,
            ),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              context.go('/login/private');
            },
            child: SizedBox(
              height: 14,
              child: Text(
                '회원 로그인에 필요한 개인정보 제공에 동의합니다.',
                semanticsLabel: '두 번 탭해 개인정보 처리 방침 자세히 보기',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.gray600,
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

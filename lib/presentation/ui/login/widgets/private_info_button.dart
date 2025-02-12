import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
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
      child: Container(
        height: 50,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 21,
              width: 21,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xFFD9B3FE))
              ),
              child: _isChecked
                  ? Icon(Icons.check, size: 19, color: Color(0xFF5902B0))
                  : null,
            ),
            SizedBox(width: 8),
            // flutter package easy_rich_text 사용!
            EasyRichText(
              '개인정보 수집 및 이용에 동의하시겠습니까?',
              defaultStyle: TextStyle(
                fontSize: 13,
                color: Color(0xFF8D8D8D),
              ),
              patternList: [
                EasyRichTextPattern(
                    targetString: '개인정보 수집 및 이용',
                    style: TextStyle(color: Color(0xFFD28BBA)),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.go('/login/private');
                      }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

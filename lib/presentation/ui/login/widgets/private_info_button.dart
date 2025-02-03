import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivateInfoButton extends StatelessWidget {
  const PrivateInfoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/login/private');
      },
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
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(Icons.check,
                  size: 19, color: Color(0xFF1C1B1F)),
            ),
            SizedBox(width: 8),
            // flutter package easy_rich_text 사용!
            EasyRichText(
              '로그인을 클릭하면 동의 및 개인정보에 동의하는 것으로 간주됩니다.',
              defaultStyle: TextStyle(
                fontSize: 11,
                color: Color(0xFF8D8D8D),
              ),
              patternList: [
                EasyRichTextPattern(
                  targetString: '동의 및 개인정보',
                  style: TextStyle(color: Color(0xFFD28BBA)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

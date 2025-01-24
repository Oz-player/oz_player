import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/my_page/sample_page.dart';
import 'package:oz_player/presentation/ui/my_page/widgets/settings_button.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: Text(
        '마이페이지',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey[900],
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 36),
            Container(
              height: 128,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(height: 36),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '설정',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            VersionInfo(),
            SettingsButton(
              text: '개인정보 보호 방침',
              goToThePage: SamplePage(),
            ),
            SettingsButton(
              text: '알림 설정',
              goToThePage: SamplePage(),
            ),
            SettingsButton(
              text: '내보내기',
              goToThePage: SamplePage(),
            ),
            SettingsButton(
              text: '문의하기',
              goToThePage: SamplePage(),
            ),
            ExitButtons(),
          ],
        ),
      ),
    );
  }
}

//==========================================
// 로그아웃 회원탈퇴 위젯
class ExitButtons extends StatelessWidget {
  const ExitButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textButton('로그아웃', () {}),
          Transform.translate(
            offset: Offset(0, 1.75),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 10,
              width: 2,
              decoration: BoxDecoration(
                color: Color(0xFF6B7684),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          textButton('회원탈퇴', () {}),
        ],
      ),
    );
  }

  GestureDetector textButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        color: Colors.transparent,
        child: Text(
          text,
          style: TextStyle(
            height: 17 / 14,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}

//==========================================
// 버전 위젯
class VersionInfo extends StatelessWidget {
  const VersionInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            '버전 안내',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[900],
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Text(
            '최신 버전',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(width: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey[300],
            ),
            child: Text(
              '1.1.1',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 17/14),
            ),
          ),
        ],
      ),
    );
  }
}

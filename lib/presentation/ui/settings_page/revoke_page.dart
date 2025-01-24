import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/settings_page/widgets/revoke_reason_button.dart';

class RevokePage extends StatefulWidget {
  const RevokePage({super.key});

  @override
  State<RevokePage> createState() => _RevokePageState();
}

class _RevokePageState extends State<RevokePage> {
  int selectedButtonIndex = -1;

  void _selectButton(int index) {
    setState(() {
      selectedButtonIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            '회원탈퇴',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[900],
              height: 1.4,
            ),
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '정말로 탈퇴하시겠습니까?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                height: 1.4,
              ),
            ),
            SizedBox(height: 12),
            Text(
              '떠나시는 이유를 공유해주시면 더 나은 서비스를\n제공할 수 있도록 노력하겠습니다',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
            SizedBox(height: 48),
            RevokeReasonButton(
              isSelected: selectedButtonIndex == 0,
              onPressed: () => _selectButton(0),
              text: 'ooooooooo',
            ),
            RevokeReasonButton(
              isSelected: selectedButtonIndex == 1,
              onPressed: () => _selectButton(1),
              text: 'ooooooooo',
            ),
            RevokeReasonButton(
              isSelected: selectedButtonIndex == 2,
              onPressed: () => _selectButton(2),
              text: 'ooooooooo',
            ),
            RevokeReasonButton(
              isSelected: selectedButtonIndex == 3,
              onPressed: () => _selectButton(3),
              text: 'ooooooooo',
            ),
            RevokeReasonButton(
              isSelected: selectedButtonIndex == 4,
              onPressed: () => _selectButton(4),
              text: '기타',
            ),
            SizedBox(height: 68),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 13),
                backgroundColor: Color(0xFF40017E),
                foregroundColor: Colors.white,
                textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600, height: 1.4),
              ),
              onPressed: () {
                print('탈퇴하기 선택됨');
              },
              child: Text('탈퇴하기'),
            ),
          ],
        ),
      ),
    );
  }
}

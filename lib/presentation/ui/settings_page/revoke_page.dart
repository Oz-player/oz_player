import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/login/login_view_model.dart';
import 'package:oz_player/presentation/ui/settings_page/widgets/revoke_reason_button.dart';
import 'package:oz_player/presentation/widgets/home_tap/bottom_navigation_view_model/bottom_navigation_view_model.dart';

class RevokePage extends ConsumerStatefulWidget {
  const RevokePage({super.key});

  @override
  ConsumerState<RevokePage> createState() => _RevokePageState();
}

class _RevokePageState extends ConsumerState<RevokePage> {
  int selectedButtonIndex = -1;

  void _selectButton(int index) {
    setState(() {
      selectedButtonIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deleteUserViewModel = ref.read(loginViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            '회원탈퇴',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF191F28),
              height: 1.4,
            ),
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '떠나신다니 아쉬워요...',
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
                text: '서비스를 자주 사용하지 않아요',
              ),
              RevokeReasonButton(
                isSelected: selectedButtonIndex == 1,
                onPressed: () => _selectButton(1),
                text: '추천 음악이 마음에 들지 않았어요',
              ),
              RevokeReasonButton(
                isSelected: selectedButtonIndex == 2,
                onPressed: () => _selectButton(2),
                text: '개인 정보 보호가 걱정돼요',
              ),
              RevokeReasonButton(
                isSelected: selectedButtonIndex == 3,
                onPressed: () => _selectButton(3),
                text: '원하는 기능이 부족했어요',
              ),
              RevokeReasonButton(
                isSelected: selectedButtonIndex == 4,
                onPressed: () => _selectButton(4),
                text: '앱이 자주 오류가 나거나 충돌했어요',
              ),
              SizedBox(height: 68),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(horizontal: 36, vertical: 13),
                  backgroundColor: selectedButtonIndex == -1
                      ? Color(0xFFEFF1F3)
                      : Color(0xFF40017E),
                  foregroundColor: selectedButtonIndex == -1
                      ? Color(0xFFADB5BD)
                      : Colors.white,
                  textStyle: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, height: 1.4),
                ),
                onPressed: selectedButtonIndex == -1
                    ? null
                    : () async {
                        await deleteUserViewModel.deleteUser(context, selectedButtonIndex);
                        ref.read(bottomNavigationProvider.notifier).resetPage();
                      },
                child: Text('탈퇴하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

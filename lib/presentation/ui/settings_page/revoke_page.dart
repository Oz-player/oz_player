import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/login/login_view_model.dart';
import 'package:oz_player/presentation/ui/settings_page/widgets/revoke_reason_button.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';
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
        title: ExcludeSemantics(
          child: Text(
            '회원탈퇴',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.gray900,
              height: 1.4,
            ),
          ),
        ),
        leading: Semantics(
          button: true,
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back,
              semanticLabel: '돌아가기',
            ),
            color: Colors.grey[900],
          ),
        ),
      ),
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
              Semantics(
                hint: '탈퇴 사유를 선택한 후 맨 아래의 탈퇴하기 버튼을 클릭해주세요.',
                child: Text(
                  '떠나시는 이유를 공유해주시면 더 나은 서비스를\n제공할 수 있도록 노력하겠습니다',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
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
                      ? AppColors.gray300
                      : AppColors.main800,
                  foregroundColor: selectedButtonIndex == -1
                      ? AppColors.gray400
                      : Colors.white,
                  textStyle: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, height: 1.4),
                ),
                onPressed: selectedButtonIndex == -1
                    ? null
                    : () async {
                        if (context.mounted) {
                          await deleteUserViewModel.deleteUser(
                              context, selectedButtonIndex, ref);
                        }
                        ref.read(audioPlayerViewModelProvider.notifier).toggleStop();
                        ref.read(bottomNavigationProvider.notifier).resetPage();
                      },
                child: Text(
                  '탈퇴하기',
                  semanticsLabel:
                      selectedButtonIndex == -1 ? '먼저 탈퇴 사유를 선택해주세요.' : '탈퇴하기',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

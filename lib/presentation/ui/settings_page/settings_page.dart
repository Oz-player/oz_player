import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/login/login_view_model.dart';
import 'package:oz_player/presentation/ui/settings_page/sample_page.dart';
import 'package:oz_player/presentation/ui/settings_page/version_view_model.dart';
import 'package:oz_player/presentation/ui/settings_page/widgets/settings_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            '설정',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[900],
              height: 1.4,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 24),
            SubTitle(text: '알림'),
            SizedBox(height: 12),
            SettingsButton(
              text: '알림 설정',
              goToThePage: SamplePage(),
            ),
            Divider(),
            SizedBox(height: 28),
            SubTitle(text: '약관·정보'),
            SizedBox(height: 12),
            SettingsButton(
              text: '개인정보 보호 방침',
              goToThePage: SamplePage(),
            ),
            VersionInfo(),
            Divider(),
            SizedBox(height: 28),
            SubTitle(text: '일반'),
            SizedBox(height: 12),
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

//==============================================================
// 서브 타이틀 텍스트

// ignore: must_be_immutable
class SubTitle extends StatelessWidget {
  String text;

  SubTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 19 / 16,
        ),
      ),
    );
  }
}

//=============================================================
// 로그아웃 회원탈퇴 위젯
class ExitButtons extends ConsumerWidget {
  const ExitButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textButton('로그아웃', () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                content: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          '잠깐!\n정말 로그아웃 하시겠어요?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          '확인 버튼을 누르면 로그아웃됩니다',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7684),
                            height: 1.4,
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                    padding: WidgetStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        EdgeInsets.symmetric(
                                            horizontal: 21, vertical: 10)),
                                    backgroundColor: WidgetStatePropertyAll(
                                        Color(0xFFF2E6FF)),
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)))),
                                onPressed: () {
                                  context.pop();
                                },
                                child: Text(
                                  '나중에 할게요',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF6B7684),
                                      fontWeight: FontWeight.w500,
                                      height: 1.4),
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            TextButton(
                                style: ButtonStyle(
                                    padding: WidgetStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        EdgeInsets.symmetric(
                                            horizontal: 47, vertical: 10)),
                                    backgroundColor: WidgetStatePropertyAll(
                                        Color(0xFF40017E)),
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)))),
                                onPressed: () async {
                                  print('로그아웃 확인 버튼 선택함!');
                                  final loginViewModel =
                                      ref.read(loginViewModelProvider.notifier);
                                  await loginViewModel.logout();

                                  // ignore: use_build_context_synchronously
                                  context.go('/login');
                                },
                                child: Text(
                                  '확인',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    height: 1.4,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                        top: -164,
                        left: 0,
                        right: 0,
                        child: Image.asset('assets/char/oz_2.png')),
                  ],
                ),
              ),
            );
          }),
          Transform.translate(
            offset: Offset(0, 0.25),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 10,
              width: 2,
              decoration: BoxDecoration(
                color: Color(0xFFADB5BD),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          textButton('회원탈퇴', () {
            context.go('/settings/revoke');
          }),
        ],
      ),
    );
  }

  // 로그아웃, 회원탈퇴
  GestureDetector textButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 49,
        color: Colors.transparent,
        child: Text(
          text,
          style: TextStyle(
            height: 17 / 14,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFFADB5BD),
          ),
        ),
      ),
    );
  }
}

//==================================================================
// 버전 위젯
class VersionInfo extends ConsumerWidget {
  const VersionInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appVersion = ref.watch(versionViewModelProvider);

    return SizedBox(
      height: 64,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            '버전 안내',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7684),
              fontWeight: FontWeight.w500,
              height: 17 / 14,
            ),
          ),
          Spacer(),
          Text(
            '최신 버전',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7684),
              height: 17 / 14,
            ),
          ),
          SizedBox(width: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color(0xFFF2E6FF),
            ),
            child: Text(
              appVersion,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF7303E3),
                height: 17 / 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

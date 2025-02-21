import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/login/login_view_model.dart';

class KakaoButton extends ConsumerWidget {
  final bool activated;

  const KakaoButton({
    super.key,
    required this.activated,
  });

  // void kakaoLogin(BuildContext context) async {
  //   final isInstalled = await isKakaoTalkInstalled();
  //   final kakaoLoginResult = isInstalled
  //       ? await UserApi.instance.loginWithKakaoTalk()
  //       : await UserApi.instance.loginWithKakaoAccount();
  //   print(kakaoLoginResult.idToken);

  //   final httpClient = Client();
  //   final httpResponse = await httpClient.post(
  //     Uri.parse('https://kakaologin-erb5lhs57a-uc.a.run.app'),
  //     body: {'idToken': kakaoLoginResult.idToken},
  //   );
  //   if (httpResponse.statusCode != 200) {
  //     return;
  //   }

  //   final functionsIdToken = httpResponse.body;
  //   final loginCred =
  //       await FirebaseAuth.instance.signInWithCustomToken(functionsIdToken);
  //   print('loginCred.user?.uid ${loginCred.user?.uid}');

  //   if (loginCred.user?.uid != null) {
  //     // ignore: use_build_context_synchronously
  //     context.go('/home');
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(64),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: activated
            ? () async {
                try {
                  await ref.read(loginViewModelProvider.notifier).kakaoLogin();
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('카카오 로그인 실패! $e')),
                  );
                }
              }
            : () {
                showDialog(
                  context: context,
                  builder: (context) => Semantics(
                    label: '개인정보 수집 및 이용에 대한 동의가 필요합니다.',
                    child: AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        '안내',
                        textAlign: TextAlign.center,
                      ),
                      content: Text(
                        '로그인하기 전에\n 개인정보 수집 및 이용에 동의해주세요.',
                        textAlign: TextAlign.center,
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('확인'),
                        ),
                      ],
                    ),
                  ),
                );
              },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 54),
          padding: EdgeInsets.zero,
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, height: 19 / 16),
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Color(0xFFFEE500),
          foregroundColor: Colors.black87,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ic_kakao_logo.png',
              color: Colors.black,
              height: 24,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(width: 10),
            Text('Kakao로 시작하기'),
          ],
        ),
      ),
    );
  }
}

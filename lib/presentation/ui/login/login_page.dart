import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/login/login_view_model.dart';
import 'package:oz_player/presentation/ui/login/widgets/apple_button.dart';
import 'package:oz_player/presentation/ui/login/widgets/google_button.dart';
import 'package:oz_player/presentation/ui/login/widgets/kakao_button.dart';
import 'package:oz_player/presentation/ui/login/widgets/private_info_button.dart';
import 'package:oz_player/presentation/ui/saved/view_models/library_view_model.dart';
import 'package:oz_player/presentation/ui/saved/view_models/list_sort_viewmodel.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_view_model.dart';
import 'package:oz_player/presentation/widgets/home_tap/bottom_navigation_view_model/bottom_navigation_view_model.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _isChecked = false;

  void _checkState(bool isChecked) {
    setState(() {
      _isChecked = isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider);

    // 로그인 상태가 success일 때, 페이지 이동
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (loginState == LoginState.success) {
        ref.read(bottomNavigationProvider.notifier).resetPage();
        await ref.watch(playListViewModelProvider.notifier).getPlayLists();
        await ref.watch(libraryViewModelProvider.notifier).getLibrary();
        ref.watch(listSortViewModelProvider.notifier).setLatest();
        if (context.mounted) {
          context.go('/home');
        }
      }
    });

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background_1.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 166),
                  SizedBox(
                    width: 164,
                    child: Image.asset('assets/images/muoz.png'),
                  ),
                  SizedBox(height: 28.5),
                  Text(
                    '당신만의 신비로운 음악을\n찾아보세요',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600, height: 1.4),
                  ),
                  Spacer(flex: 264),
                  GoogleButton(activated: _isChecked),
                  KakaoButton(activated: _isChecked),
                  AppleButton(activated: _isChecked), // IOS에서만 애플 로그인 버튼 보임
                  SizedBox(height: 24),
                  PrivateInfoButton(onChecked: _checkState),
                  // SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

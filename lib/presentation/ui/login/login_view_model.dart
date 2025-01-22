import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/providers/login/providers.dart';

enum LoginState { idle, loading, success, error }

class LoginViewModel extends Notifier<LoginState> {
  late final _googleLoginUseCase = ref.read(googleLoginUseCaseProvider);
  late final _appleLoginUseCase = ref.read(appleLoginUseCaseProvider);

  LoginViewModel();

  @override
  LoginState build() => LoginState.idle;

  Future<void> googleLogin() async {
    state = LoginState.loading;
    try {
      await _googleLoginUseCase.execute(); // GoogleLogin UseCase 호출
      state = LoginState.success;
    } catch (e) {
      state = LoginState.error;
    }
  }

  Future<void> appleLogin() async {
    if (!Platform.isIOS) {
      // IOS가 아닌 경우 애플 로그인 X
      state = LoginState.error;
      return;
    }

    state = LoginState.loading;
    try {
      await _appleLoginUseCase.execute(); // AppleLogin UseCase 호출
      state = LoginState.success;
    } catch (e) {
      state = LoginState.error;
    }
  }
}

final loginViewModelProvider = NotifierProvider<LoginViewModel, LoginState>(
  () => LoginViewModel(),
);

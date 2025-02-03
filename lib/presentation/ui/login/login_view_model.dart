import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/providers/login/providers.dart';
import 'package:oz_player/presentation/view_model/user_view_model.dart';

enum LoginState { idle, loading, success, error }

class LoginViewModel extends Notifier<LoginState> {
  late final _googleLoginUseCase = ref.read(googleLoginUseCaseProvider);
  late final _appleLoginUseCase = ref.read(appleLoginUseCaseProvider);
  late final _kakaoLoginUseCase = ref.read(kakaoLoginUseCaseProvider);
  late final _logoutUseCase = ref.read(logoutUseCaseProvider);

  LoginViewModel();

  @override
  LoginState build() => LoginState.idle;

  Future<void> googleLogin() async {
    state = LoginState.loading;
    try {
      final login = await _googleLoginUseCase.execute(); // GoogleLogin UseCase 호출
      ref.read(userViewModelProvider.notifier).setUserId(login[1]);

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
      final login = await _appleLoginUseCase.execute(); // AppleLogin UseCase 호출
      ref.read(userViewModelProvider.notifier).setUserId(login[1]);
      
      state = LoginState.success;
    } catch (e) {
      state = LoginState.error;
    }
  }

  Future<void> kakaoLogin() async {
    state = LoginState.loading;
    try {
      final login = await _kakaoLoginUseCase.execute();
      ref.read(userViewModelProvider.notifier).setUserId(login[0]);

      state = LoginState.success;

    } catch (e) {
      state = LoginState.error;
    }
  }

  Future<void> logout() async {
    state = LoginState.loading;
    try {
      await _logoutUseCase.execute();

      ref.read(userViewModelProvider.notifier).initUser();
      state = LoginState.idle;
    } catch (e) {
      //
      state = LoginState.error;
    }
  }
}

final loginViewModelProvider = NotifierProvider<LoginViewModel, LoginState>(
  () => LoginViewModel(),
);

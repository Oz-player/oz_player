import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/providers/login/providers.dart';
import 'package:oz_player/presentation/view_model/user_view_model.dart';

enum LoginState { idle, loading, success, error }

class LoginViewModel extends Notifier<LoginState> {
  late final _googleLoginUseCase = ref.read(googleLoginUseCaseProvider);
  late final _appleLoginUseCase = ref.read(appleLoginUseCaseProvider);
  late final _kakaoLoginUseCase = ref.read(kakaoLoginUseCaseProvider);
  late final _logoutUseCase = ref.read(logoutUseCaseProvider);
  late final _deleteUserUseCase = ref.read(deleteUserUseCaseProvider);
  late final _revokeReasonUsecase = ref.read(revokeReasonUsecaseProvider);

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

  Future<void> deleteUser(BuildContext context, int index) async {
    state = LoginState.loading;
    try {
      await updateRevokeReason(index);
      await _deleteUserUseCase.execute();

      ref.read(userViewModelProvider.notifier).initUser();
      state = LoginState.idle;

      // ignore: use_build_context_synchronously
      context.go('/login');
    } catch (e) {
      state = LoginState.error;
    }
  }

  Future<void> updateRevokeReason(int index) async {
    await _revokeReasonUsecase.execute(index);
  }
}

final loginViewModelProvider = NotifierProvider<LoginViewModel, LoginState>(
  () => LoginViewModel(),
);

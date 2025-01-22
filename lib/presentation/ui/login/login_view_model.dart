import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/usecase/login/google_login_use_case.dart';
import 'package:oz_player/providers.dart';

class LoginViewModel extends StateNotifier<String> {
  final GoogleLoginUseCase _googleLoginUseCase;

  LoginViewModel(this._googleLoginUseCase) : super('');

  void startLoading() => state = 'loading';
  void stopLoading() => state = '';

  Future<List<String>> googleLogin() async {
    try {
      startLoading();
      final route =
          await _googleLoginUseCase.execute(); // GoogleLogin UseCase 호출
      print('$route');
      // 로그인 성공 후 route 따라 페이지 이동
      return route;
    } catch (e) {
      return ['error', ''];
    } finally {
      // stopLoading();
    }
  }
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, String>((ref) {
  final googleLoginUseCase = ref.read(googleLoginUseCaseProvider);
  return LoginViewModel(googleLoginUseCase);
});

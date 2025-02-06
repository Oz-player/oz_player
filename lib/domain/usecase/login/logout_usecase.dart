

import 'package:oz_player/domain/repository/login/logout_repository.dart';

class LogoutUsecase {
  final LogoutRepository _logoutRepository;

  LogoutUsecase(this._logoutRepository);

  Future<void> execute() async {
    await _logoutRepository.logout(); // 모든 소셜 로그인 로그아웃
  }
}
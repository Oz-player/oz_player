

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oz_player/domain/repository/login/logout_repository.dart';

class LogoutUsecase {
  final LogoutRepository _logoutRepository;

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  LogoutUsecase(this._logoutRepository);

  Future<void> execute() async {
    await _logoutRepository.logout(); // 모든 소셜 로그인 로그아웃
    await _storage.delete(key: 'user_uid');
  }
}
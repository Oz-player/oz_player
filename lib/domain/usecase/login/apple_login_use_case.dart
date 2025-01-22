import 'package:oz_player/domain/repository/login/apple_login_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginUseCase {
  final AppleLoginRepository _appleLoginRepository;

  AppleLoginUseCase(this._appleLoginRepository);

  Future<void> execute() async {
    try {

      // apple 로그인 정보 요청
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );

      // 로그인 성공하면 uid, email 정보 받기
      final uid = appleCredential.userIdentifier;
      final email = appleCredential.email;

      if (uid == null || email == null) {
        throw Exception('사용자 정보 받기 실패!');
      }


      // 기존 사용자 찾기
      final isExistUser = await _appleLoginRepository.isExistUser(uid);

      if (isExistUser) {
        // 기존 사용자면 데이터 업데이트
        await _appleLoginRepository.updateUser(uid, email);
      } else {
        // 새로운 사용자면 데이터 등록
        await _appleLoginRepository.createUser(uid, email);
      }
    } catch (e) {
      //
      throw Exception('애플 로그인 실패! $e');
    }
  }
}

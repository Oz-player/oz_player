import 'package:firebase_auth/firebase_auth.dart';
import 'package:oz_player/domain/repository/login/apple_login_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginUseCase {
  final AppleLoginRepository _appleLoginRepository;

  AppleLoginUseCase(this._appleLoginRepository);

  Future<List<String>> execute() async {
    try {
      // apple 로그인 정보 요청
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );

      // 로그인 성공하면 uid, email 정보 받기
      final uid = appleCredential.userIdentifier;
      final email = 'zzzzzz@gmail.com'; // 나중에 다시 해보기!
      print('!!!!!!!!!!!');
      print('$uid, $email');

      if (uid == null) {
        throw Exception('사용자 정보 받기 실패!');
      }

      // // Firebase Auth 정보 생성(애플 로그인에서 받은 credential로)
      final appleOAuthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );


      // 받은 Token 이용해서 Apple 계정으로 인증받은 사용자 정보 Firebase Auth에 등록
      final userCredential = await FirebaseAuth.instance.signInWithCredential(appleOAuthCredential);
      final firebaseUid = userCredential.user?.uid;

      if (firebaseUid == null) {
        throw Exception('Firebase 인증 실패!');
      }

      final firebaseEmail = userCredential.user?.email ?? email;


      // 기존 사용자 찾기
      final isExistUser = await _appleLoginRepository.isExistUser(firebaseUid);

      if (isExistUser) {
        print('createUser 호출 전');
        // 기존 사용자면 데이터 업데이트
        await _appleLoginRepository.updateUser(firebaseUid, firebaseEmail!);
      } else {
        // 새로운 사용자면 데이터 등록
        await _appleLoginRepository.createUser(firebaseUid, firebaseEmail!);
        print('createUser 호출 완료');
      }

      return ['/home', firebaseUid];
    } catch (e) {
      print('$e');
      throw Exception('애플 로그인 실패! $e');
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:oz_player/domain/repository/login/google_login_repository.dart';

class GoogleLoginUseCase {
  final GoogleLoginRepository googleLoginRepository;

  GoogleLoginUseCase(this.googleLoginRepository);

  Future<List<String>> execute() async {
    try {
      // google 계정으로 로그인
      final googleLogin = await googleLoginRepository.signInWithGoogle();
      if (googleLogin == null) {
        throw Exception('Google 로그인 실패!');
      }

      // Firebase Auth 정보 생성
      final googleAuth = await googleLogin.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 받은 Token 이용해서 google 계정으로 인증받은 사용자 정보 Firebase Auth에 등록
      final userCredential = await googleLoginRepository.signInWithFirebase(credential);
      final uid = userCredential.user?.uid;

      if (uid == null) {
        throw Exception('Firebase 인증 실패!');
      }

      final email = userCredential.user?.email;
      if (email == null) {
        throw Exception('Firebase 사용자 이메일 없음!');
      }

      // // Database에서 기존 사용자 검색
      // final userDocs = await googleLoginRepository.fetchUserEmail(email);

      // // 기존 사용자, 기존사용자지만 추천카테고리 미입력 사용자 이동페이지 다르게 TODO
      // //

      // 새로운 사용자는 Firestore 데이터 저장 후 홈페이지로 이동
      await googleLoginRepository.saveNewUser(uid, email);
      return ['home', uid];
    } catch (e) {
      //
      rethrow;
    }
  }
}

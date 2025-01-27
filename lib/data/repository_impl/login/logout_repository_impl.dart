import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oz_player/domain/repository/login/logout_repository.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  LogoutRepositoryImpl(this._googleSignIn, this._firebaseAuth);

  @override
  Future<void> logout() async {
    // 구글 로그인 한거 로그아웃
    try {
      await _googleSignIn.signOut();
    } catch (_) {} 

    // Firebase에서 로그아웃(모든 소셜 로그인)
    await _firebaseAuth.signOut();
  }
}

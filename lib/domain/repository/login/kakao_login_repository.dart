import 'package:firebase_auth/firebase_auth.dart';

abstract interface class KakaoLoginRepository {
  Future<String?> getKakaoIdToken();
  Future<String> fetchKakaoIdToken(String idToken);
  Future<UserCredential> signInWithFirebase(String idToken);
  Future<bool> isExistUser(String uid);
  Future<void> saveNewUser(String uid);
}

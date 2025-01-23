import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AppleLoginRepository {
  Future<bool> isExistUser(String uid);
  Future<UserCredential> signInWithAppleFirebase(OAuthCredential credential);
  Future<void> updateUser(String uid, String email);
  Future<void> createUser(String uid, String email);
}
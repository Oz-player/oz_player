import 'package:firebase_auth/firebase_auth.dart';

abstract interface class DeleteUserRepository {
  Future<void> reauthKakaoUser();
  Future<AuthCredential?> reauthUser();
  Future<void> deleteUser();
  Future<void> revokeAppleAccount(String authorizationCode);
}



import 'package:firebase_auth/firebase_auth.dart';
import 'package:oz_player/data/source/login/apple_login_data_source.dart';
import 'package:oz_player/domain/repository/login/apple_login_repository.dart';

class AppleLoginRepositoryImpl implements AppleLoginRepository {
  final AppleLoginDataSource _appleLoginDataSource;

  AppleLoginRepositoryImpl(this._appleLoginDataSource);

   @override
  Future<UserCredential> signInWithAppleFirebase(OAuthCredential credential) {
    return _appleLoginDataSource.signInWithAppleFirebase(credential);
  }

  @override
  Future<bool> isExistUser(String uid) async {
    return await _appleLoginDataSource.isExistUser(uid);
  }

  @override
  Future<void> updateUser(String uid, String email) async {
    return await _appleLoginDataSource.updateUser(uid, email);
  }
  
  @override
  Future<void> createUser(String uid, String email) async {
    return await _appleLoginDataSource.createUser(uid, email);
  }

 
}
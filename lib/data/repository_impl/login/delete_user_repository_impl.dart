

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:oz_player/data/source/login/delete_user_data_source.dart';
import 'package:oz_player/domain/repository/login/delete_user_repository.dart';

class DeleteUserRepositoryImpl implements DeleteUserRepository {
  final DeleteUserDataSource _dataSource;

  DeleteUserRepositoryImpl(this._dataSource);

  
  @override
  Future<void> reauthKakaoUser() async {
    await _dataSource.reauthKakaoUser();
  }

  @override
  Future<void> reauthUser() async {
    await _dataSource.reauthUser(); // provider 소셜 로그인 종류에 맞춰서 실행
  }


  @override
  Future<void> deleteUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _dataSource.deleteAuthUser(); // firebase auth 계정 삭제
      await _dataSource.deleteFirestoreUser(user.uid); // firestore 계정 삭제
    } else {
      throw Exception('$e');
    }
  }
  
  @override
  Future<void> revokeAppleAccount() async {
    await _dataSource.revokeAppleAccount();
  }
  
  
  
  

  
}
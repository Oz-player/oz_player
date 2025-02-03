

import 'package:firebase_auth/firebase_auth.dart';
import 'package:oz_player/data/source/login/kakao_login_data_source.dart';
import 'package:oz_player/domain/repository/login/kakao_login_repository.dart';

class KakaoLoginRepositoryImpl implements KakaoLoginRepository {
  final KakaoLoginDataSource dataSource;

  KakaoLoginRepositoryImpl({required this.dataSource});

  @override
  Future<String?> getKakaoIdToken() async {
    return await dataSource.getKakaoIdToken();
  }


  @override
  Future<String> fetchKakaoIdToken(String idToken) async {
    return await dataSource.fetchKakaoIdToken(idToken);
  }

   @override
  Future<UserCredential> signInWithFirebase(String idToken) async {
    return await dataSource.signInWithFirebase(idToken);
  }

  @override
  Future<bool> isExistUser(String uid) async {
    return await dataSource.isExistUser(uid);
  }

  @override
  Future<void> saveNewUser(String uid) async {
    return await dataSource.saveNewUser(uid);
  }

 
}
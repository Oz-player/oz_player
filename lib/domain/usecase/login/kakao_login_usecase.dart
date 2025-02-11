import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oz_player/domain/repository/login/kakao_login_repository.dart';

class KakaoLoginUsecase {
  final KakaoLoginRepository repository;

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  KakaoLoginUsecase({required this.repository});

  Future<List<String>> execute() async {
    try {
      final idToken = await repository.getKakaoIdToken();
      if (idToken == null) {
        throw Exception('$e');
      }

      final functionsIdToken = await repository.fetchKakaoIdToken(idToken);

      final userCredential =
          await repository.signInWithFirebase(functionsIdToken);
      final uid = userCredential.user?.uid;
      if (uid == null) {
        throw Exception('$e');
      }

      final isExistingUser = await repository.isExistUser(uid);
      if (!isExistingUser) {
        await repository.saveNewUser(uid);
      }
      print('카카오 로그인 성공! uid: $uid');

      // 자동 로그인에 필요(로그인 성공 후 uid 저장)
      await _storage.write(
        key: 'user_uid',
        value: uid,
      );

      return [uid, '/home'];
    } catch (e) {
      print('$e');
      throw Exception('$e');
    }
  }
}

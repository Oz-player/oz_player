import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oz_player/domain/repository/login/delete_user_repository.dart';

class DeleteUserUsecase {
  final DeleteUserRepository _repository;
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  DeleteUserUsecase(this._repository, this._auth, this._firestore);

  Future<void> execute() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('$e');

    final uid = user.uid;
    final userDoc = await _firestore.collection('User').doc(uid).get();
    final isKakaoUser = userDoc.exists && uid.startsWith('kakao');

    final isAppleUser =
        user.providerData.any((provider) => provider.providerId == 'apple.com');

    if (isKakaoUser) {
      await _repository.reauthKakaoUser();
    } else if (isAppleUser) {
      final credential = await _repository.reauthUser();

      final authorizationCode = credential!.accessToken;

      await _repository.revokeAppleAccount(authorizationCode!);
    } else {
      await _repository.reauthUser();
    }
    await _repository.deleteUser();
  }
}

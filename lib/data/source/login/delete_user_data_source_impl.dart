import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart' as kakao;
import 'package:oz_player/data/source/login/delete_user_data_source.dart';

class DeleteUserDataSourceImpl implements DeleteUserDataSource {
  final auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  DeleteUserDataSourceImpl({
    required auth.FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  @override
  Future<void> deleteAuthUser() async {
    auth.User? user = _auth.currentUser;
    if (user == null) {
      throw Exception('$e');
    }
    await user.delete();
  }

  @override
  Future<void> deleteFirestoreUser(String uid) async {
    await _firestore.collection('User').doc(uid).delete();
  }

  @override
  Future<void> reauthUser() async {
    auth.User? user = _auth.currentUser;
    if (user == null) throw Exception('$e');
    
    final providerId = user.providerData.first.providerId;
    print('현재 로그인된 providerId: $providerId');
    auth.AuthCredential? credential;

    if (providerId == 'google.com') {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.idToken != null) {
        credential = auth.GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken,
          accessToken: googleAuth?.accessToken,
        );
      }
    } else if (providerId == 'apple.com') {
      credential = auth.OAuthProvider('apple.com').credential();
    } else if (providerId == 'kakao.com') {
      await reauthKakaoUser();
      return;
    }
    if (credential != null) {
      await user.reauthenticateWithCredential(credential);
      print('재인증 성공!');
    } else {
      throw Exception('재인증 실패');
    }
  }

  @override
  Future<void> reauthKakaoUser() async {
    auth.User? user = _auth.currentUser;
    if (user == null) {
      throw Exception('$e');
    }
    try {
      final isInstalled = await kakao.isKakaoTalkInstalled();
      final kakaoLoginResult = isInstalled
          ? await kakao.UserApi.instance.loginWithKakaoTalk()
          : await kakao.UserApi.instance.loginWithKakaoAccount();

      final idToken = kakaoLoginResult.idToken;
      if (idToken == null) throw Exception('$e');

      // 재인증은 카카오에서 받은 idToken으로 Firebase 인증
      final cred = auth.OAuthProvider('kakao.com').credential(idToken: idToken);
      await user.reauthenticateWithCredential(cred);

      print('카카오 재인증 성공!');
    } catch (e) {
      print('계정 재인증 실패!');
    }
  }
}

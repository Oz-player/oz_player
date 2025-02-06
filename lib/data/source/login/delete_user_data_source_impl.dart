import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart' as kakao;
import 'package:oz_player/data/source/login/delete_user_data_source.dart';
import 'package:http/http.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
  Future<auth.AuthCredential?> reauthUser() async {
    auth.User? user = _auth.currentUser;
    if (user == null) throw Exception('$e');

    final providerId = user.providerData.first.providerId;
    print('현재 로그인된 providerId: $providerId');
    auth.AuthCredential? credential;

    final uid = user.uid;
    final userDoc = await _firestore.collection('User').doc(uid).get();
    final isKakaoUser = userDoc.exists && uid.startsWith('kakao');

    if (isKakaoUser) {
      print('카카오 로그인 사용자! 카카오 재인증 진행');
      await reauthKakaoUser();
      return null;
    }

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
      try {
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [AppleIDAuthorizationScopes.email],
        );

        if (appleCredential.identityToken == null) {
          throw Exception('$e');
        }

        credential = auth.OAuthProvider('apple.com').credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );
      } catch (e) {
        print('애플로그인 재인증 실패! $e');
      }
    }
    if (credential != null) {
      
      await user.reauthenticateWithCredential(credential);
      print('재인증 성공!');
      return credential;
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

      final httpClient = Client();
      final httpResponse = await httpClient.post(
        Uri.parse('https://kakaologin-erb5lhs57a-uc.a.run.app'),
        body: {'idToken': idToken},
      );
      if (httpResponse.statusCode == 200) {
        final customToken = httpResponse.body;

        //
        await auth.FirebaseAuth.instance.signInWithCustomToken(customToken);
        print('카카오 재인증 성공!');
      } else {
        throw Exception('$e');
      }
    } catch (e) {
      print('계정 재인증 실패!: $e');
    }
  }

  @override
  Future<void> revokeAppleAccount(String authorizationCode) async {
    try {
      await _auth.revokeTokenWithAuthorizationCode(authorizationCode);
      print('애플 탈퇴 성공!');
    } catch (e) {
      //
      print('애츨 탈퇴 실패! $e');
      throw Exception();
    }
  }
}



  // functions 연동문제
  // @override
  // Future<void> revokeAppleAccount() async {
   
  //   try {
  //     final callable = _functions.httpsCallable('revokeAppleAccount');
  //     final response = await callable.call();

  //     if (response.data['success'] != true) {
  //       throw Exception('$e');
  //     }
  //   } catch (e) {
  //     throw Exception('Firebase Functions 오류! $e');
  //   }
  // }
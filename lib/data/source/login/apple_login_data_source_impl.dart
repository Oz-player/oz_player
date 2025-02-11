import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oz_player/data/source/login/apple_login_data_source.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginDataSourceImpl implements AppleLoginDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AppleLoginDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  @override
  Future<Map<String, String>> signInWithApple() async {
    try {
      // 애플 로그인 정보 가져오기
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );

      final uid = appleCredential.userIdentifier ?? 'unknown_uid';
      final email = appleCredential.email ?? 'unknown_email';

      // uid, email(애플 로그인 정보)
      final Map<String, String> userInfo = {
        'uid': uid, // 애플로그인에서 받은 사용자 고유 ID
        'email': email,
      };
      return userInfo;
    } catch (e) {
      throw Exception('$e');
    }
  }

  @override
  Future<UserCredential> signInWithAppleFirebase(
      OAuthCredential credential) async {
    try {
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isExistUser(String uid) async {
    final docRef = _firestore.collection('User').doc(uid);
    final docSnapshot = await docRef.get();
    return docSnapshot.exists;
  }

  @override
  Future<void> updateUser(String uid, String email) async {
    try {
      final docRef = _firestore.collection('User').doc(uid);
      await docRef.update({
        'email': email,
      });
    } catch (e) {
      log('사용자 정보 업데이트 실패! $e');
    }
  }

  @override
  Future<void> createUser(String uid, String? email) async {
    log('Firestore createUser 호출: uid=$uid, email=$email');
    try {
      final docRef = _firestore.collection('User').doc(uid);
      final nullableEmail = email ?? 'unKnown'; // email이 null값으로 올 때, 기본값
      await docRef.set({
        'uid': uid,
        'email': nullableEmail,
      });
      log('새로운 사용자 생성 완료! $uid, $nullableEmail');
    } catch (e) {
      log('사용자 생성 실패! $e');
    }
  }

  @override
  Future<void> saveUser() async {
    try {
      final userInfo = await signInWithApple();
      final uid = userInfo['uid']!;
      final email = userInfo['email'];
      
      final existUser = await isExistUser(uid);

      if (existUser) {
        await createUser(uid, email ?? 'unKnown');
      } else {
        await createUser(uid, email);
      }
      log('새로운 사용자 Firestore Database에 저장완료!: $uid, $email');
    } catch (e) {
      log('새로운 사용자 Firestore Database에 저장 실패!: $e');
    }
  }
}

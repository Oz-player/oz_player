

import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AppleLoginDataSource {
  Future<Map<String, String>> signInWithApple();
  Future<UserCredential> signInWithAppleFirebase(OAuthCredential credential); // Firebase 인증
  Future<bool> isExistUser(String uid); // Firestore에서 기존 사용자인지 확인
  Future<void> updateUser(String uid, String email); // Firestore에 기존 사용자 업데이트
  Future<void> createUser(String uid, String email); // Firestore에 새로운 사용자 생성
  Future<void> saveUser(); // Firestore에 새로운 사용자 정보 저장
}


import 'package:firebase_auth/firebase_auth.dart';

abstract interface class KakaoLoginDataSource {
  Future<String?> getKakaoIdToken(); // 카카오 로그인 후 카카오로부터 idToken 발급받음
  Future<String> fetchKakaoIdToken(String idToken); // functions에서 카카오 로그인 처리후 firebase custom token 반환
  Future<UserCredential> signInWithFirebase(String idToken); // custom Token으로 Firebase 사용자 로그인
  Future<bool> isExistUser(String uid); // 기존 사용자 검색 
  Future<void> saveNewUser(String uid); // 새로운 사용자 Firestore에 저장
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract interface class GoogleLoginRepository {
  Future<GoogleSignInAccount?> signInWithGoogle(); // google 계정으로 로그인
  Future<UserCredential> signInWithFirebase(OAuthCredential credential); // firebase 인증
  Future<QuerySnapshot> fetchUserEmail(String email); // email로 기존 사용자 검색
  Future<void> saveNewUser(String uid, String email); // 새로운 사용자 생성
}

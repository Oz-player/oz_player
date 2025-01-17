import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oz_player/data/source/google_login_data_source.dart';

// google sign in 이랑 firebase 연동
// firestore에 사용자 정보 저장

class GoogleLoginDataSourceImpl implements GoogleLoginDataSource {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  GoogleLoginDataSourceImpl({
    required GoogleSignIn googleSignIn,
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _googleSignIn = googleSignIn,
        _auth = auth,
        _firestore = firestore;

  @override
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      return googleSignInAccount;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> signInWithFirebase(OAuthCredential credential) async {
    try {
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<QuerySnapshot<Object?>> fetchUserEmail(String email) async {
    try {
      final snapshot = await _firestore
          .collection('User')
          .where('email', isEqualTo: email)
          .get();
      return snapshot;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveNewUser(String uid, String email) async {
    try {
      final userDoc = _firestore.collection('User').doc(uid);
      await userDoc.set({
        'uid': uid,
        'email': email,
      });

      print('새로운 사용자 Firestore Database에 저장완료!: $uid, $email');
    } catch (e) {
      print('저장실패!: $e');
    }
  }
}

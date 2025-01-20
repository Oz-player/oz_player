import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oz_player/data/source/google_login_data_source.dart';
import 'package:oz_player/domain/repository/google_login_repository.dart';

class GoogleLoginRepositoryImpl implements GoogleLoginRepository {
  final GoogleLoginDataSource _googleLoginDataSource;

  GoogleLoginRepositoryImpl(this._googleLoginDataSource);

  @override
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    return _googleLoginDataSource.signInWithGoogle();
  }

  @override
  Future<UserCredential> signInWithFirebase(OAuthCredential credential) {
    return _googleLoginDataSource.signInWithFirebase(credential);
  }

  @override
  Future<QuerySnapshot<Object?>> fetchUserEmail(String email) {
    return _googleLoginDataSource.fetchUserEmail(email);
  }

  @override
  Future<void> saveNewUser(String uid, String email) {
    return _googleLoginDataSource.saveNewUser(uid, email);
  }
}

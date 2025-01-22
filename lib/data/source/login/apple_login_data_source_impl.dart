import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oz_player/data/source/login/apple_login_data_source.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginDataSourceImpl implements AppleLoginDataSource {
  final FirebaseFirestore _firestore;

  AppleLoginDataSourceImpl(this._firestore);

  @override
  Future<Map<String, String>> signInWithApple() async {
    try {
      // 애플 로그인 정보 가져오기
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );

      final uid = appleCredential.userIdentifier ?? 'unknown_uid';
      final email = appleCredential.email ?? 'unknown_email';

      // uid, email 
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
  Future<bool> isExistUser(String uid) async {
    final docRef = _firestore.collection('User').doc(uid);
    final docSnapshot = await docRef.get();
    return docSnapshot.exists;
  }

  @override
  Future<void> updateUser(String uid, String email) async {
    final docRef = _firestore.collection('User').doc(uid);
    await docRef.update(
      {
        // 'uid': uid,
        'email': email,
      },
    );
  }

  @override
  Future<void> createUser(String uid, String email) async {
    final docRef = _firestore.collection('User').doc(uid);
    await docRef.set(
      {
        'uid': uid,
        'email': email,
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:oz_player/data/source/login/kakao_login_data_source.dart';

class KakaoLoginDataSourceImpl implements KakaoLoginDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  KakaoLoginDataSourceImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  @override
  Future<String?> getKakaoIdToken() async {
    try {
      final isInstalled = await isKakaoTalkInstalled();
      final kakaoLoginResult = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final idToken = kakaoLoginResult.idToken;
      return idToken;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> fetchKakaoIdToken(String idToken) async {
    final httpClient = Client();
    print('카카오 서버로 요청 전송 중... idToken: $idToken');
    try {
      final httpResponse = await httpClient.post(
        Uri.parse('https://kakaologin-erb5lhs57a-uc.a.run.app'),
        body: {'idToken': idToken},
      );
      print('${httpResponse.statusCode}');
      if (httpResponse.statusCode == 200) {
        return httpResponse.body;
      } else {
        throw Exception(
            '카카오 서버 통신 오류: 상태 코드 ${httpResponse.statusCode}, 응답: ${httpResponse.body}');
      }
    } catch (e) {
      rethrow;
    } finally {
      httpClient.close();
    }
  }

  @override
  Future<UserCredential> signInWithFirebase(String idToken) async {
    try {
      // Custom Token으로 로그인
      final userCredential = await _auth.signInWithCustomToken(idToken);
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isExistUser(String uid) async {
    try {
      final userSnapshot = await _firestore.collection('User').doc(uid).get();
      return userSnapshot.exists;
    } catch (e) {
      print('$e');
      rethrow;
    }
  }

  @override
  Future<void> saveNewUser(String uid) async {
    try {
      final userDoc = _firestore.collection('User').doc(uid);
      await userDoc.set({
        'uid': uid,
        'provider': 'kakao.com',
      }, SetOptions(merge: true));
      
      print('새로운 사용자 Firestore Database에 저장완료!: $uid');
    } catch (e) {
      print('새로운 사용자 Firestore Database에 저장 실패!: $e');
      rethrow;
    }
  }
}

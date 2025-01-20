import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:oz_player/data/source/login/google_login_data_source_impl.dart';

@GenerateNiceMocks([
  MockSpec<GoogleSignIn>(),
  MockSpec<FirebaseAuth>(),
  MockSpec<FirebaseFirestore>(),
  MockSpec<GoogleSignInAccount>(),
  MockSpec<OAuthCredential>(),
  MockSpec<UserCredential>(),
  MockSpec<CollectionReference>(),
  MockSpec<DocumentReference>(),
  MockSpec<DocumentSnapshot>(),
  MockSpec<Query>(),
  MockSpec<QuerySnapshot>(),
  MockSpec<QueryDocumentSnapshot>(),
])
import 'google_login_data_source_impl_test.mocks.dart';

void main() {
  group('google login', () {
    test('연습1', () async {
      // 준비
      MockGoogleSignIn mockGoogleSignIn = MockGoogleSignIn();
      MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
      MockFirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
      GoogleLoginDataSourceImpl googleSignIn = GoogleLoginDataSourceImpl(
        googleSignIn: mockGoogleSignIn,
        firestore: mockFirebaseFirestore,
        auth: mockFirebaseAuth,
      );
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async {
        return MockGoogleSignInAccount();
      });

      // 실행
      GoogleSignInAccount? account = await googleSignIn.signInWithGoogle();
      // 검증, 검사 (통과함!!!)
      expect(account, isA<GoogleSignInAccount>());
    });

    test('연습2', () async {
      // 준비
      MockGoogleSignIn mockGoogleSignIn = MockGoogleSignIn();
      MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
      MockFirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
      GoogleLoginDataSourceImpl googleSignIn = GoogleLoginDataSourceImpl(
        googleSignIn: mockGoogleSignIn,
        firestore: mockFirebaseFirestore,
        auth: mockFirebaseAuth,
      );
      // Mock OAuthCredential
      final credential = MockOAuthCredential();
      final mockUserCredential = MockUserCredential();

      when(mockFirebaseAuth.signInWithCredential(credential))
          .thenAnswer((_) async {
        return mockUserCredential;
      });

      // 실행
      UserCredential accountt =
          await googleSignIn.signInWithFirebase(credential);
      // 검증, 검사 (통과함!!!)
      expect(accountt, isA<UserCredential>());
    });

    test('연습3', () async {
      // 내가 받았으면 하는 결과값
      final mockData = {'email': 'uuumonazzz@gmail.com'};

      // 변수 세팅
      MockGoogleSignIn mockGoogleSignIn = MockGoogleSignIn();
      MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
      MockFirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
      GoogleLoginDataSourceImpl googleSignIn = GoogleLoginDataSourceImpl(
        googleSignIn: mockGoogleSignIn,
        firestore: mockFirebaseFirestore,
        auth: mockFirebaseAuth,
      );
      MockCollectionReference<Map<String, dynamic>> mockCollectionReference =
          MockCollectionReference<Map<String, dynamic>>();
      MockQuery<Map<String, dynamic>> mockQuery = MockQuery();
      MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot =
          MockQuerySnapshot();
      MockQueryDocumentSnapshot<Map<String, dynamic>>
          mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();

      // 반환값을 Mock변수로 지정
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);

      when(mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')))
          .thenReturn(mockQuery);

      when(mockQuery.get(any)).thenAnswer((_) async => mockQuerySnapshot);

      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);

      when(mockQueryDocumentSnapshot.data()).thenReturn(mockData);

      // 실행
      QuerySnapshot<Map<String, dynamic>?> accountt =
          await googleSignIn.fetchUserEmail('uuumonazzz@gmail.com');
      DocumentSnapshot<Map<String, dynamic>?> documentSnapshot =
          accountt.docs[0];
      Map<String, dynamic> data = documentSnapshot.data()!;

      // 검증, 검사 (통과함!!!)
      expect(accountt, isA<QuerySnapshot>());
      expect(data['email'], equals('uuumonazzz@gmail.com'));
    });

    test('연습4', () async {
      //
    });


  });
}

// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mockito/mockito.dart';
// import 'package:oz_player/data/source/google_login_data_source_impl.dart';

// @GenerateNiceMocks([
//   MockSpec<GoogleSignIn>(),
//   MockSpec<FirebaseAuth>(),
//   MockSpec<FirebaseFirestore>(),
//   MockSpec<GoogleSignInAccount>(),
//   MockSpec<OAuthCredential>(), 
//   MockSpec<UserCredential>(),
// ])
// import 'google_login_data_source_impl_test.mocks.dart';

// void main() {
//   group('google login', () {
//     test('연습1', () async {
//       // 준비
//       MockGoogleSignIn mockGoogleSignIn = MockGoogleSignIn();
//       MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
//       MockFirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
//       GoogleLoginDataSourceImpl googleSignIn = GoogleLoginDataSourceImpl(
//         googleSignIn: mockGoogleSignIn,
//         firestore: mockFirebaseFirestore,
//         auth: mockFirebaseAuth,
//       );
//       when(mockGoogleSignIn.signIn()).thenAnswer((_) async {
//         return MockGoogleSignInAccount();
//       });

//       // 실행
//       GoogleSignInAccount? account = await googleSignIn.signInWithGoogle();
//       // 검증, 검사 (통과함!!!)
//       expect(account, isA<GoogleSignInAccount>());
//     });

//     test('연습2', () async {
//       // 준비
//       MockGoogleSignIn mockGoogleSignIn = MockGoogleSignIn();
//       MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
//       MockFirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
//       GoogleLoginDataSourceImpl googleSignIn = GoogleLoginDataSourceImpl(
//         googleSignIn: mockGoogleSignIn,
//         firestore: mockFirebaseFirestore,
//         auth: mockFirebaseAuth,
//       ); 
//       // Mock OAuthCredential
//       final credential = MockOAuthCredential();
//       final mockUserCredential = MockUserCredential();

//       when(mockFirebaseAuth.signInWithCredential(credential)).thenAnswer((_) async {
//         return mockUserCredential;
//       });

//       // 실행
//       UserCredential accountt = await googleSignIn.signInWithFirebase(credential);
//       // 검증, 검사 (통과함!!!)
//       expect(accountt, isA<UserCredential>());
//     });
//   });
// }

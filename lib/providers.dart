import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oz_player/data/repository_impl/login/google_login_repository_impl.dart';
import 'package:oz_player/data/source/login/google_login_data_source.dart';
import 'package:oz_player/data/source/login/google_login_data_source_impl.dart';
import 'package:oz_player/domain/repository/login/google_login_repository.dart';
import 'package:oz_player/domain/usecase/login/google_login_use_case.dart';

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final googleLoginDataSourceProvider = Provider<GoogleLoginDataSource>((ref) {
  final googleSignIn = ref.read(googleSignInProvider);
  final auth = ref.read(firebaseAuthProvider);
  final firestore = ref.read(firestoreProvider);
  return GoogleLoginDataSourceImpl(
    googleSignIn: googleSignIn,
    auth: auth,
    firestore: firestore,
  );
});

final googleLoginRepositoryProvider = Provider<GoogleLoginRepository>((ref) {
  final dataSource = ref.read(googleLoginDataSourceProvider);
  return GoogleLoginRepositoryImpl(dataSource);
});

final googleLoginUseCaseProvider = Provider<GoogleLoginUseCase>((ref) {
  final repository = ref.read(googleLoginRepositoryProvider);
  return GoogleLoginUseCase(repository);
});



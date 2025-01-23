import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oz_player/data/repository_impl/gemini_repository_impl.dart';
import 'package:oz_player/data/repository_impl/login/apple_login_repository_impl.dart';
import 'package:oz_player/data/repository_impl/login/google_login_repository_impl.dart';
import 'package:oz_player/data/repository_impl/video_info_repository_impl.dart';
import 'package:oz_player/data/source/ai_source.dart';
import 'package:oz_player/data/source/gemini_source_impl.dart';
import 'package:oz_player/data/source/login/apple_login_data_source.dart';
import 'package:oz_player/data/source/login/apple_login_data_source_impl.dart';
import 'package:oz_player/data/source/login/google_login_data_source.dart';
import 'package:oz_player/data/source/login/google_login_data_source_impl.dart';
import 'package:oz_player/domain/repository/gemini_repository.dart';
import 'package:oz_player/domain/repository/login/apple_login_repository.dart';
import 'package:oz_player/domain/repository/login/google_login_repository.dart';
import 'package:oz_player/domain/repository/video_info_repository.dart';
import 'package:oz_player/domain/usecase/login/apple_login_use_case.dart';
import 'package:oz_player/domain/usecase/login/google_login_use_case.dart';
import 'package:oz_player/domain/usecase/video_info_usecase.dart';
import 'package:oz_player/presentation/view_model/user_view_model.dart';

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

// =====================================================================
// 여기부터 apple login 클린아키텍처 의존성 주입

final appleLoginDataSourceProvider = Provider<AppleLoginDataSource>((ref) {
  final firestore = ref.read(firestoreProvider);
  final auth = ref.read(firebaseAuthProvider);
  return AppleLoginDataSourceImpl(
    firestore: firestore,
    auth: auth,
  );
});

final appleLoginRepositoryProvider = Provider<AppleLoginRepository>((ref) {
  final dataSource = ref.read(appleLoginDataSourceProvider);
  return AppleLoginRepositoryImpl(dataSource);
});

final appleLoginUseCaseProvider = Provider<AppleLoginUseCase>((ref) {
  final repository = ref.read(appleLoginRepositoryProvider);
  return AppleLoginUseCase(repository);
});

final aiSourceProvider = Provider<AiSource>((ref){
  return GeminiSourceImpl();
});

final geiminiRepositoryProvider = Provider<GeminiRepository>((ref){
  final aiSource = ref.watch(aiSourceProvider);
  return GeminiRepositoryImpl(aiSource);
});

final videoInfoRepositoryProvider = Provider<VideoInfoRepository>((ref){
  return VideoInfoRepositoryImpl();
});

final videoInfoUsecaseProvider = Provider<VideoInfoUsecase>((ref){
  final videoInfoRepository = ref.read(videoInfoRepositoryProvider);
  return VideoInfoUsecase(videoInfoRepository);
});

final userViewModelProvider =
    StateNotifierProvider<UserViewmodel, String>((ref) {
  return UserViewmodel();
});
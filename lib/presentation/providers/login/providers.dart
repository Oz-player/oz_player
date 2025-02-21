import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oz_player/data/repository_impl/gemini_repository_impl.dart';
import 'package:oz_player/data/repository_impl/login/apple_login_repository_impl.dart';
import 'package:oz_player/data/repository_impl/login/delete_user_repository_impl.dart';
import 'package:oz_player/data/repository_impl/login/google_login_repository_impl.dart';
import 'package:oz_player/data/repository_impl/login/kakao_login_repository_impl.dart';
import 'package:oz_player/data/repository_impl/login/logout_repository_impl.dart';
import 'package:oz_player/data/repository_impl/login/revoke_reason_repository_impl.dart';
import 'package:oz_player/data/repository_impl/video_info_repository_impl.dart';
import 'package:oz_player/data/source/ai_source.dart';
import 'package:oz_player/data/source/gemini_source_impl.dart';
import 'package:oz_player/data/source/login/apple_login_data_source.dart';
import 'package:oz_player/data/source/login/apple_login_data_source_impl.dart';
import 'package:oz_player/data/source/login/delete_user_data_source.dart';
import 'package:oz_player/data/source/login/delete_user_data_source_impl.dart';
import 'package:oz_player/data/source/login/google_login_data_source.dart';
import 'package:oz_player/data/source/login/google_login_data_source_impl.dart';
import 'package:oz_player/data/source/login/kakao_login_data_source.dart';
import 'package:oz_player/data/source/login/kakao_login_data_source_impl.dart';
import 'package:oz_player/data/source/login/revoke_reason_data_source.dart';
import 'package:oz_player/data/source/login/revoke_reason_data_source_impl.dart';
import 'package:oz_player/data/source/spotify/spotify_data_source.dart';
import 'package:oz_player/data/source/spotify/spotify_data_source_impl.dart';
import 'package:oz_player/domain/repository/gemini_repository.dart';
import 'package:oz_player/domain/repository/login/apple_login_repository.dart';
import 'package:oz_player/domain/repository/login/delete_user_repository.dart';
import 'package:oz_player/domain/repository/login/google_login_repository.dart';
import 'package:oz_player/domain/repository/login/kakao_login_repository.dart';
import 'package:oz_player/domain/repository/login/logout_repository.dart';
import 'package:oz_player/domain/repository/login/revoke_reason_repository.dart';
import 'package:oz_player/domain/repository/video_info_repository.dart';
import 'package:oz_player/domain/usecase/login/apple_login_use_case.dart';
import 'package:oz_player/domain/usecase/login/delete_user_usecase.dart';
import 'package:oz_player/domain/usecase/login/google_login_use_case.dart';
import 'package:oz_player/domain/usecase/login/kakao_login_usecase.dart';
import 'package:oz_player/domain/usecase/login/logout_usecase.dart';
import 'package:oz_player/domain/usecase/login/revoke_reason_usecase.dart';
import 'package:oz_player/domain/usecase/video_info_usecase.dart';

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

// ========================================================
// 여기부터 kakao login 클린아키텍처 의존성 주입

final kakaoLoginDataSourceProvider = Provider<KakaoLoginDataSource>((ref) {
  final firestore = ref.read(firestoreProvider);
  final auth = ref.read(firebaseAuthProvider);
  return KakaoLoginDataSourceImpl(
    auth: auth,
    firestore: firestore,
  );
});

final kakaoLoginRepositoryProvider = Provider<KakaoLoginRepository>((ref) {
  final dataSource = ref.read(kakaoLoginDataSourceProvider);
  return KakaoLoginRepositoryImpl(dataSource: dataSource);
});

final kakaoLoginUseCaseProvider = Provider<KakaoLoginUsecase>((ref) {
  final repository = ref.read(kakaoLoginRepositoryProvider);
  return KakaoLoginUsecase(repository: repository);
});

// ========================================================
// 로그아웃 프로바이더

final logoutRepositoryProvider = Provider<LogoutRepository>((ref) {
  final googleSignIn = ref.read(googleSignInProvider);
  final auth = ref.read(firebaseAuthProvider);

  return LogoutRepositoryImpl(googleSignIn, auth);
});

final logoutUseCaseProvider = Provider<LogoutUsecase>((ref) {
  final repository = ref.read(logoutRepositoryProvider);
  return LogoutUsecase(repository);
});

// ========================================================
// 계정삭제(탈퇴) 프로바이더

final deleteUserDataSourceProvider = Provider<DeleteUserDataSource>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final firestore = ref.read(firestoreProvider);

  return DeleteUserDataSourceImpl(auth: auth, firestore: firestore);
});

final deleteUserRepositoryProvider = Provider<DeleteUserRepository>((ref) {
  final deleteUserDataSource = ref.read(deleteUserDataSourceProvider);
  return DeleteUserRepositoryImpl(deleteUserDataSource);
});

final deleteUserUseCaseProvider = Provider<DeleteUserUsecase>((ref) {
  final repository = ref.read(deleteUserRepositoryProvider);
  final auth = ref.read(firebaseAuthProvider);
  final firestore = ref.read(firestoreProvider);
  return DeleteUserUsecase(repository, auth, firestore);
});

// ========================================================
// 계정삭제(탈퇴) 이유 프로바이더

final revokeReasonDataSourceProvider = Provider<RevokeReasonDataSource>((ref) {
  final firestore = ref.read(firestoreProvider);
  return RevokeReasonDataSourceImpl(firestore);
});

final revokeReasonRepositoryProvider = Provider<RevokeReasonRepository>((ref) {
  final revokeReasonDatasource = ref.read(revokeReasonDataSourceProvider);
  return RevokeReasonRepositoryImpl(revokeReasonDatasource);
});

final revokeReasonUsecaseProvider = Provider<RevokeReasonUsecase>((ref) {
  final revokeReasonRepository = ref.read(revokeReasonRepositoryProvider);
  return RevokeReasonUsecase(revokeReasonRepository);
});



// ========================================================

final aiSourceProvider = Provider<AiSource>((ref) {
  return GeminiSourceImpl();
});

final geiminiRepositoryProvider = Provider<GeminiRepository>((ref) {
  final aiSource = ref.watch(aiSourceProvider);
  return GeminiRepositoryImpl(aiSource);
});

final videoInfoRepositoryProvider = Provider<VideoInfoRepository>((ref) {
  return VideoInfoRepositoryImpl();
});

final videoInfoUsecaseProvider = Provider<VideoInfoUsecase>((ref) {
  final videoInfoRepository = ref.read(videoInfoRepositoryProvider);
  return VideoInfoUsecase(videoInfoRepository);
});

final spotifySourceProvider = Provider<SpotifyDataSource>((ref) {
  return SpotifyDataSourceImpl();
});



abstract interface class DeleteUserDataSource {
  Future<void> deleteAuthUser(); // firebase auth에서 삭제
  Future<void> deleteFirestoreUser(String uid); // firestore에서 삭제
  Future<void> reauthUser(); // 소셜로그인은 5분지나면 재인증 요청함. 그래서 필요! (google, apple)
  Future<void> reauthKakaoUser(); // kakao는 functions를 이용하니까 따로 빼줌
  Future<void> revokeAppleAccount(); // 애플도 탈퇴부분 functions로
}
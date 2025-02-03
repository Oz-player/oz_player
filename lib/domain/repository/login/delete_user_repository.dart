abstract interface class DeleteUserRepository {
  // Future<void> reauthKakaoUser();
  Future<void> reauthUser();
  Future<void> deleteUser();
}

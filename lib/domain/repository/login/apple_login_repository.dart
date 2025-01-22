

abstract interface class AppleLoginRepository {
  Future<bool> isExistUser(String uid);
  Future<void> updateUser(String uid, String email);
  Future<void> createUser(String uid, String email);
}
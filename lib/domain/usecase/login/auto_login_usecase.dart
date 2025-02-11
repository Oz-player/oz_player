import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 앱실행시 사용자 로그인 상태 확인!

class AutoLoginUsecase {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> execute() async {
    return await _storage.read(
      key: 'user_uid',
    );
  }
}

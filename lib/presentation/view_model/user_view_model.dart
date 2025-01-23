import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserViewmodel extends StateNotifier<String> {
  UserViewmodel() : super('');

  void setUserId(String userid) {
    state = userid;
  }

  String getUserId() {
    return state;
  }
}
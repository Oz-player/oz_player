import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserViewModel extends StateNotifier<String> {
  UserViewModel() : super('');

  void setUserId(String userid) {
    state = userid;
  }

  String getUserId() {
    return state;
  }
}

final userViewModelProvider =
    StateNotifierProvider<UserViewModel, String>((ref) {
  return UserViewModel();
});

import 'package:oz_player/domain/repository/login/delete_user_repository.dart';

class DeleteUserUsecase {
  final DeleteUserRepository _repository;

  DeleteUserUsecase(this._repository);

  Future<void> execute() async {
    await _repository.reauthUser();
    await _repository.deleteUser();
  }
}

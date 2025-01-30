import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/repository/library_repository.dart';

class LibraryUsecase {
  final LibraryRepository _repository;

  LibraryUsecase(this._repository);

  Future<List<LibraryEntity>> getLibrary(String userId) async {
    return await _repository.getLibrary(userId);
  }
}

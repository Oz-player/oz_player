import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/repository/saved/library_repository.dart';

class LibraryUsecase {
  final LibraryRepository _repository;
  final String userId;

  LibraryUsecase(this._repository, this.userId);

  Future<List<LibraryEntity>> getLibrary() async {
    return await _repository.getLibrary(userId);
  }
}

import 'package:oz_player/data/dto/library_dto.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/repository/saved/library_repository.dart';

class LibraryUsecase {
  final LibraryRepository _repository;
  final String userId;

  LibraryUsecase(this._repository, this.userId);

  Future<List<LibraryEntity>> getLibrary() async {
    return await _repository.getLibrary(userId);
  }

  Future<void> createLibrary(LibraryEntity entity) async {
    final dto = LibraryDto.fromEntity(entity);
    return await _repository.createLibrary(dto, userId);
  }

  Future<void> deleteLibrary(String songId) async {
    return await _repository.deleteLibrary(songId, userId);
  }
}

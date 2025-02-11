import 'package:oz_player/data/dto/library_dto.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/repository/saved/library_repository.dart';

class LibraryUsecase {
  final LibraryRepository _repository;

  LibraryUsecase(this._repository);

  Future<List<LibraryEntity>> getLibrary(String userId) async {
    return await _repository.getLibrary(userId);
  }

  Future<void> createLibrary(String userId, LibraryEntity entity) async {
    final dto = LibraryDto.fromEntity(entity);
    return await _repository.createLibrary(dto, userId);
  }

  Future<void> deleteLibrary(
      String userId, DateTime createdAt, String songId) async {
    return await _repository.deleteLibrary(songId, createdAt, userId);
  }

  Future<void> clearLibrary(String userId) async {
    await _repository.clearLibrary(userId);
  }
}

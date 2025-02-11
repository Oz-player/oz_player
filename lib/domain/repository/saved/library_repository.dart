import 'package:oz_player/data/dto/library_dto.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';

abstract interface class LibraryRepository {
  Future<List<LibraryEntity>> getLibrary(String userId);
  Future<void> createLibrary(LibraryDto dto, String userId);
  Future<void> deleteLibrary(String songId, DateTime createdAt, String userId);
}

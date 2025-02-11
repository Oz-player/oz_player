import 'package:oz_player/data/dto/library_dto.dart';

abstract interface class LibrarySource {
  Future<List<LibraryDto>> getLibrary(String userId);
  Future<void> createLibrary(LibraryDto dto, String userId);
  Future<void> deleteLibrary(String songId, DateTime createdAt, String userId);
  Future<void> clearLibrary(String userId);
}

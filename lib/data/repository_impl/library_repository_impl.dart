import 'package:oz_player/data/dto/library_dto.dart';
import 'package:oz_player/data/source/firebase_songs/library_source.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/repository/saved/library_repository.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final LibrarySource _source;

  LibraryRepositoryImpl(this._source);

  @override
  Future<List<LibraryEntity>> getLibrary(String userId) async {
    final dtos = await _source.getLibrary(userId);
    return dtos.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> createLibrary(LibraryDto dto, String userId) async {
    await _source.createLibrary(dto, userId);
  }

  @override
  Future<void> deleteLibrary(
      String songId, DateTime createdAt, String userId) async {
    await _source.deleteLibrary(songId, createdAt, userId);
  }
}

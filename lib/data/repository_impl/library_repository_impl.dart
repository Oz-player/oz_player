import 'package:oz_player/data/source/saved/library_source.dart';
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
}

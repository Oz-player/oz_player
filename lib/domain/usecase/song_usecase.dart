import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/domain/repository/song_repository.dart';

class SongUsecase {
  final SongRepository _repository;

  SongUsecase(this._repository);

  Future<SongEntity?> getSong(
      String songId, LibraryEntity libraryEntity) async {
    return await _repository.getSong(songId, libraryEntity);
  }
}

import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/song_entitiy.dart';
import 'package:oz_player/domain/repository/song_repository.dart';

class SongUsecase {
  final SongRepository _repository;

  SongUsecase(this._repository);

  Future<SongEntitiy?> getSong(
      String songId, LibraryEntity libraryEntity) async {
    return await _repository.getSong(songId, libraryEntity);
  }
}

import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/song_entitiy.dart';

abstract interface class SongRepository {
  Future<SongEntitiy?> getSong(String songId, LibraryEntity libraryEntity);
}

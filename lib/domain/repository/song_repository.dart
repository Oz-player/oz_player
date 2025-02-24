import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';

abstract interface class SongRepository {
  Future<SongEntity?> getSong(String songId, LibraryEntity libraryEntity);
  Future<List<SongEntity>> getSongs(List<String> songIds);
}

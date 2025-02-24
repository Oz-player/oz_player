import 'package:oz_player/domain/entitiy/maniadb/maniadb_artist_entity.dart';
import 'package:oz_player/domain/entitiy/maniadb/maniadb_song_entity.dart';

abstract interface class ManiadbRepository {
  Future<List<ManiadbArtistEntity>?> fetchArtist(String query);

  Future<List<ManiadbSongEntity>?> fetchSong(String query);
}
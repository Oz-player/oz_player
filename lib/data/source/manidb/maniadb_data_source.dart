import 'package:oz_player/data/dto/mania/maniadb_artist_dto.dart';
import 'package:oz_player/data/dto/mania/maniadb_song_dto.dart';

abstract interface class ManiadbDataSource {
  Future<List<ManiadbArtistDto>> fetchArtist(String query);

  Future<List<ManiadbSongDto>> fetchSong(String query);
}
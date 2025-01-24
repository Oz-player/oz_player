import 'package:oz_player/data/source/manidb/maniadb_data_source.dart';
import 'package:oz_player/domain/entitiy/maniadb/maniadb_artist_entity.dart';
import 'package:oz_player/domain/entitiy/maniadb/maniadb_song_entity.dart';
import 'package:oz_player/domain/repository/maniadb_repository.dart';

class ManiadbRepositoryImpl implements ManiadbRepository {
  ManiadbRepositoryImpl(this._maniadbDataSource);
  final ManiadbDataSource _maniadbDataSource;

  @override
  Future<List<ManiadbArtistEntity>?> fetchArtist(String query) async {
    final result = await _maniadbDataSource.fetchArtist(query);
    return result
        .map(
          (e) => ManiadbArtistEntity(
            title: e.title,
            demographic: e.demographic,
            period: e.period,
            image: e.image,
            majorSongList: e.majorSongList,
          ),
        )
        .toList();
  }

  @override
  Future<List<ManiadbSongEntity>?> fetchSong(String query) async {
    final result = await _maniadbDataSource.fetchSong(query);
    return result
        .map(
          (e) => ManiadbSongEntity(
            title: e.title,
            album: e.album,
            artist: e.artist,
          ),
        )
        .toList();
  }
}

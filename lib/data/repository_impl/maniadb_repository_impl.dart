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
            id: e.id,
            title: e.title,
            reference: e.reference,
            demographic: e.demographic,
            period: e.period,
            link: e.link,
            image: e.image,
            linkGallery: e.linkGallery,
            linkDiscography: e.linkDiscography,
            pubDate: e.pubDate,
            author: e.author,
            description: e.description,
            guid: e.guid,
            comments: e.comments,
            majorSongs: e.majorSongs,
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
            id: e.id,
            title: e.title,
            runningTime: e.runningTime,
            link: e.link,
            pubDate: e.pubDate,
            author: e.author,
            description: e.description,
            comments: e.comments,
            album: e.album,
            artist: e.artist,
          ),
        )
        .toList();
  }
}

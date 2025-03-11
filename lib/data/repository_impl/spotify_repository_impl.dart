import 'package:oz_player/data/source/spotify/spotify_data_source.dart';
import 'package:oz_player/domain/entitiy/spotify_entity.dart';
import 'package:oz_player/domain/repository/spotify_repository.dart';

class SpotifyRepositoryImpl implements SpotifyRepository{
  SpotifyRepositoryImpl(this._spotifyDataSource);
  final SpotifyDataSource _spotifyDataSource;

  @override
  Future<List<SpotifyEntity>?> searchList(String query) async{
    final result = await _spotifyDataSource.searchList(query);
    return result
        .map(
          (e) => SpotifyEntity(
            id: e.id,
            name: e.name,
            type: e.type,
            uri: e.uri,
            popularity: e.popularity,
            genres: e.genres,
            followers: e.followers,
            images: e.images,
            durationMs: e.durationMs,
            explicit: e.explicit,
            previewUrl: e.previewUrl,
            album: e.album,
            artists: e.artists,
          ),
        )
        .toList();
  }
}
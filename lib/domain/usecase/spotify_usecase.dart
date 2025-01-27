import 'package:oz_player/domain/entitiy/spotify_entity.dart';
import 'package:oz_player/domain/repository/spotify_repository.dart';

class SpotifyUsecase {
  SpotifyUsecase(this._spotifyRepository);
  final SpotifyRepository _spotifyRepository;

  Future<List<SpotifyEntity>?> execute(String query) async{
    return await _spotifyRepository.searchList(query);
  }

}
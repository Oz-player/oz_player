import 'package:oz_player/domain/entitiy/spotify_entity.dart';

abstract interface class SpotifyRepository {
  Future<List<SpotifyEntity>?> searchList(String query);
}
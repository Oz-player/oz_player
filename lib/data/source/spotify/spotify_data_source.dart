import 'package:oz_player/data/dto/spotify_dto.dart';

abstract interface class SpotifyDataSource {
  Future <List<SpotifyDto>> searchList(String query);
}
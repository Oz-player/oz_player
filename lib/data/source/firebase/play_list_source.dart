import 'package:oz_player/data/dto/play_list_dto.dart';

abstract interface class PlayListSource {
  Future<List<PlayListDTO>> getPlayLists(String userId);
  Future<PlayListDTO?> getPlayList(String userId, String listName);
  Future<void> addPlayList(String userId, PlayListDTO playListDTO);
  Future<void> addSong(String userId, String listName, String songId);
}

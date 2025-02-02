import 'package:oz_player/data/dto/play_list_dto.dart';

abstract interface class PlayListSource {
  Future<List<PlayListDTO>> getPlayLists(String userId);
  Future<PlayListDTO?> getPlayList(String userId, String listName);
  Future<bool> addPlayList(String userId, PlayListDTO playListDTO);
  Future<void> addSong(String userId, String listName, String songId);
  Future<void> deletePlayList(String userId, String listName);
  Future<void> deleteSong(String userId, String listName, String songId);
  Future<void> editListName(String userId, String listName, String newName);
  Future<void> editDescription(
      String userId, String listName, String newDescription);
  Future<void> editSongOrder(
      String userId, String listName, List<String> songIds);
}

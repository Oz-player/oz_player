import 'package:oz_player/data/dto/play_list_dto.dart';
import 'package:oz_player/data/dto/raw_song_dto.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';

abstract interface class PlayListRepository {
  Future<List<PlayListEntity>> getPlayLists(String userId);
  Future<PlayListEntity?> getPlayList(String userId, String listName);
  Future<bool> addPlayList(String userId, PlayListDTO dto);
  Future<void> addSong(String userId, String listName, RawSongDto dto);
  Future<void> deletePlayList(String userId, String listName);
  Future<void> deleteSong(String userId, String listName, String songId);
  Future<void> editListName(String userId, String listName, String newName);
  Future<void> editDescription(
      String userId, String listName, String newDescription);
  Future<void> editSongOrder(
      String userId, String listName, List<String> songIds);
  Future<void> clearPlaylist(String userId);
}

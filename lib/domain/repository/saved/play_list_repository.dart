import 'package:oz_player/data/dto/play_list_dto.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';

abstract interface class PlayListRepository {
  Future<List<PlayListEntity>> getPlayLists(String userId);
  Future<PlayListEntity?> getPlayList(String userId, String listName);
  Future<bool> addPlayList(String userId, PlayListDTO playListDTO);
  Future<void> addSong(String userId, String listName, String songId);
  Future<void> deletePlayList(String userId, String listName);
  Future<void> deleteSong(String userId, String listName, String songId);
}

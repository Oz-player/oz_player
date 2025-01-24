import 'package:oz_player/data/dto/play_list_dto.dart';
import 'package:oz_player/data/source/play_list/play_list_source.dart';
import 'package:oz_player/domain/repository/play_list_repository.dart';

class PlayListRepositoryImpl implements PlayListRepository {
  final PlayListSource _source;

  PlayListRepositoryImpl(this._source);

  @override
  Future<void> addPlayList(String userId, PlayListDTO playListDTO) async {
    await _source.addPlayList(userId, playListDTO);
  }

  @override
  Future<void> addSong(String userId, String listName, String songId) async {
    await _source.addSong(userId, listName, songId);
  }

  @override
  Future<void> deletePlayList(String userId, String listName) async {
    await _source.deletePlayList(userId, listName);
  }

  @override
  Future<void> deleteSong(String userId, String listName, String songId) async {
    await _source.deleteSong(userId, listName, songId);
  }

  @override
  Future<PlayListDTO?> getPlayList(String userId, String listName) async {
    return await _source.getPlayList(userId, listName);
  }

  @override
  Future<List<PlayListDTO>> getPlayLists(String userId) async {
    return await _source.getPlayLists(userId);
  }
}

import 'package:oz_player/data/dto/play_list_dto.dart';
import 'package:oz_player/data/source/saved/play_list_source.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/domain/repository/saved/play_list_repository.dart';

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
  Future<PlayListEntity?> getPlayList(String userId, String listName) async {
    final dto = await _source.getPlayList(userId, listName);
    if (dto == null) return null;
    return dto.toEntity();
  }

  @override
  Future<List<PlayListEntity>> getPlayLists(String userId) async {
    final dtos = await _source.getPlayLists(userId);
    return dtos.map((e) => e.toEntity()).toList();
  }
}

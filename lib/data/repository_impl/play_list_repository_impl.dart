import 'package:oz_player/data/dto/play_list_dto.dart';
import 'package:oz_player/data/dto/raw_song_dto.dart';
import 'package:oz_player/data/source/firebase_songs/play_list_source.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/domain/repository/saved/play_list_repository.dart';

class PlayListRepositoryImpl implements PlayListRepository {
  final PlayListSource _source;

  PlayListRepositoryImpl(this._source);

  @override
  Future<bool> addPlayList(String userId, PlayListDTO playListDTO) async {
    return await _source.addPlayList(userId, playListDTO);
  }

  @override
  Future<void> addSong(String userId, String listName, RawSongDto dto) async {
    await _source.addSong(userId, listName, dto);
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

  @override
  Future<void> editListName(
      String userId, String listName, String newName) async {
    await _source.editListName(userId, listName, newName);
  }

  @override
  Future<void> editDescription(
      String userId, String listName, String newDescription) async {
    await _source.editDescription(userId, listName, newDescription);
  }

  @override
  Future<void> editSongOrder(
      String userId, String listName, List<String> songIds) async {
    await _source.editSongOrder(userId, listName, songIds);
  }
}

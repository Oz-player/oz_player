import 'package:oz_player/data/dto/play_list_dto.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/domain/repository/play_list_repository.dart';

class PlayListUsecase {
  final PlayListRepository _repository;

  PlayListUsecase(this._repository);

  // userId가 쓰이는 부분은 현재 유저 정보 Provider가 생기면
  // 해당 유저의 아이디로 변경하겠습니다
  Future<List<PlayListEntity>> getPlayLists(String userId) async {
    return await _repository.getPlayLists(userId);
  }

  Future<PlayListDTO?> getPlayList(String userId, String listName) async {
    return await _repository.getPlayList(userId, listName);
  }

  Future<void> addPlayList(String userId, PlayListDTO playListDTO) async {
    await _repository.addPlayList(userId, playListDTO);
  }

  Future<void> addSong(String userId, String listName, String songId) async {
    await _repository.addSong(userId, listName, songId);
  }

  Future<void> deletePlayList(String userId, String listName) async {
    await _repository.deletePlayList(userId, listName);
  }

  Future<void> deleteSong(
    String userId,
    String listName,
    String songId,
  ) async {
    await _repository.deleteSong(
      userId,
      listName,
      songId,
    );
  }
}

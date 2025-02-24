import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/domain/repository/song_repository.dart';

class SongUsecase {
  final SongRepository _repository;

  SongUsecase(this._repository);

  Future<SongEntity?> getSong(
      String songId, LibraryEntity libraryEntity) async {
    return await _repository.getSong(songId, libraryEntity);
  }

  // songIds로 video, imgUrl, artist, title 검색하고 나머지는 더미 값으로 넣은 SongEntity 리스트 생성
  Future<List<SongEntity>> getSongs(List<String> songIds) async {
    return await _repository.getSongs(songIds);
  }
}

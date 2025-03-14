import 'package:oz_player/data/dto/raw_song_dto.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/domain/repository/saved/raw_song_repository.dart';

class RawSongUsecase {
  final RawSongRepository _repository;

  RawSongUsecase(this._repository);

  Future<RawSongEntity?> getRawSong(String songId) async {
    return await _repository.getRawSong(songId);
  }

  Future<List<RawSongEntity>> getRawSongs(List<String> songIds) async {
    return await _repository.getRawSongs(songIds);
  }

  Future<void> updateRawSongByLibrary(RawSongEntity entity) async {
    final dto = RawSongDto.fromEntity(entity);
    await _repository.updateRawSongByLibrary(dto);
  }

  Future<void> updateRawSongByPlaylist(RawSongEntity entity) async {
    final dto = RawSongDto.fromEntity(entity);
    await _repository.updateRawSongByPlaylist(dto);
  }

  Future<void> updateVideo(RawSongEntity entitiy) async {
    final dto = RawSongDto.fromEntity(entitiy);
    await _repository.updateVideo(dto);
  }

  Future<List<RawSongEntity>> getCardRanking() async {
    final list = await _repository.getCardRanking();
    return list.map((e) => e.toEntity()).toList();
  }

  Future<List<RawSongEntity>> getPlaylistRanking() async {
    final list = await _repository.getPlaylistRanking();
    return list.map((e) => e.toEntity()).toList();
  }
}

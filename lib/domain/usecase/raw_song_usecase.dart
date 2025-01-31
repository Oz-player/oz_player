import 'package:oz_player/data/dto/raw_song_dto.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/domain/repository/saved/raw_song_repository.dart';

class RawSongUsecase {
  final RawSongRepository _repository;

  RawSongUsecase(this._repository);

  Future<RawSongEntity?> getRawSong(String songId) async {
    return await _repository.getRawSong(songId);
  }

  Future<void> createRawSong(RawSongEntity entity) async {
    final dto = RawSongDto.fromEntity(entity);
    await _repository.createRawSong(dto);
  }
}

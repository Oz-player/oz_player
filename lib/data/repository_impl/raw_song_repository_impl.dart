import 'package:oz_player/data/dto/raw_song_dto.dart';
import 'package:oz_player/data/source/saved/raw_song_source.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/domain/repository/saved/raw_song_repository.dart';

class RawSongRepositoryImpl implements RawSongRepository {
  final RawSongSource _source;

  RawSongRepositoryImpl(this._source);

  @override
  Future<RawSongEntity?> getRawSong(String songId) async {
    final dto = await _source.getRawSong(songId);
    if (dto == null) return null;
    return dto.toEntity();
  }

  @override
  Future<void> createRawSong(RawSongDto dto) async {
    await _source.createRawSong(dto);
  }
}

import 'package:oz_player/data/dto/raw_song_dto.dart';
import 'package:oz_player/data/source/firebase_songs/raw_song_source.dart';
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
  Future<List<RawSongEntity>> getRawSongs(List<String> songIds) async {
    final list = await _source.getRawSongs(songIds);
    return list.map((song) => song.toEntity()).toList();
  }

  @override
  Future<void> updateRawSongByLibrary(RawSongDto dto) async {
    await _source.updateRawSongByLibrary(dto);
  }

  @override
  Future<void> updateRawSongByPlaylist(RawSongDto dto) async {
    await _source.updateRawSongByPlaylist(dto);
  }

  @override
  Future<void> updateVideo(RawSongDto dto) async {
    await _source.updateVideo(dto);
  }
}

import 'package:oz_player/data/dto/raw_song_dto.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';

abstract interface class RawSongRepository {
  Future<RawSongEntity?> getRawSong(String songId);

  // 플레이리스트에서 RawSongEntity 리스트로 불러올 때 사용
  Future<List<RawSongEntity>> getRawSongs(List<String> songIds);

  // 라이브러리에서 DB에 Song 객체 업로드
  Future<void> updateRawSongByLibrary(RawSongDto dto);

  // 플레이리스트에서 DB에 Song 객체 업로드
  Future<void> updateRawSongByPlaylist(RawSongDto dto);

  // video 객체 업데이트
  Future<void> updateVideo(RawSongDto dto);
}

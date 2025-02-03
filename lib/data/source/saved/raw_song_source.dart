import 'package:oz_player/data/dto/raw_song_dto.dart';

abstract interface class RawSongSource {
  Future<RawSongDto?> getRawSong(String songId);
  Future<List<RawSongDto>> getRawSongs(List<String> songIds);
  Future<void> updateRawSongByLibrary(RawSongDto rawSongDto);
  Future<void> updateRawSongByPlaylist(RawSongDto rawSongDto);
}

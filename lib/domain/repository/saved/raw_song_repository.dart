import 'package:oz_player/data/dto/raw_song_dto.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';

abstract interface class RawSongRepository {
  Future<RawSongEntity?> getRawSong(String songId);
  Future<void> createRawSong(RawSongDto dto);
}

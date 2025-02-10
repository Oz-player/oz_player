import 'package:oz_player/data/dto/song_dto.dart';
import 'package:oz_player/data/source/firebase_songs/raw_song_source.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/domain/repository/song_repository.dart';

class SongRepositoryImpl implements SongRepository {
  final RawSongSource _rawSongSource;

  SongRepositoryImpl(this._rawSongSource);

  @override
  Future<SongEntity?> getSong(
      String songId, LibraryEntity libraryEntity) async {
    final firebase = await _rawSongSource.getRawSong(songId);
    if (firebase != null) {
      return SongDTO(rawSongDto: firebase, libraryEntity: libraryEntity)
          .toEntity();
    } else {
      return null;
    }
  }

  @override
  Future<List<SongEntity>> getSongs(List<String> songIds) async {
    LibraryEntity libraryEntity = LibraryEntity(
        createdAt: DateTime.now(),
        artist: 'artist',
        imgUrl: 'imgUrl',
        title: 'title',
        favoriteArtist: 'favoriteArtist',
        genre: 'genre',
        memo: ' memo',
        mood: 'mood',
        situation: 'situation',
        songId: 'songId');
    final firebase = await _rawSongSource.getRawSongs(songIds);
    return firebase
        .map((e) =>
            SongDTO(rawSongDto: e, libraryEntity: libraryEntity).toEntity())
        .toList();
  }
}

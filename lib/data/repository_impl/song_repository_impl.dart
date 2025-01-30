import 'package:oz_player/data/dto/song_dto.dart';
import 'package:oz_player/data/source/saved/firebase_song_source.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/song_entitiy.dart';
import 'package:oz_player/domain/repository/song_repository.dart';

class SongRepositoryImpl implements SongRepository {
  final FirebaseSongSource _firebaseSource;

  SongRepositoryImpl(this._firebaseSource);

  @override
  Future<SongEntitiy?> getSong(
      String songId, LibraryEntity libraryEntity) async {
    final firebase = await _firebaseSource.getFirebaseSong(songId);
    if (firebase != null) {
      return SongDTO(firebaseSongDTO: firebase, libraryEntity: libraryEntity)
          .toEntity();
    } else {
      return null;
    }
  }
}

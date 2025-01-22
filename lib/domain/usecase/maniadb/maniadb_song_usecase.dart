import 'package:oz_player/domain/entitiy/maniadb/maniadb_song_entity.dart';
import 'package:oz_player/domain/repository/maniadb_repository.dart';

class ManiadbSongUsecase {
  ManiadbSongUsecase(this._maniadbRepository);
  final ManiadbRepository _maniadbRepository;

  Future<List<ManiadbSongEntity>?> execute(String query) async{
    return await _maniadbRepository.fetchSong(query);
  }

}
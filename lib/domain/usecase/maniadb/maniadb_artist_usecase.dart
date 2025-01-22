import 'package:oz_player/domain/entitiy/maniadb/maniadb_artist_entity.dart';
import 'package:oz_player/domain/repository/maniadb_repository.dart';

class ManiadbArtistUsecase {
  ManiadbArtistUsecase(this._maniadbRepository);
  final ManiadbRepository _maniadbRepository;

  Future<List<ManiadbArtistEntity>?> execute(String query) async{
    return await _maniadbRepository.fetchArtist(query);
  }

}
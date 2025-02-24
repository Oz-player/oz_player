import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/data/repository_impl/maniadb_repository_impl.dart';
import 'package:oz_player/data/source/manidb/maniadb_data_source_impl.dart';
import 'package:oz_player/domain/entitiy/maniadb/maniadb_artist_entity.dart';
import 'package:oz_player/domain/repository/maniadb_repository.dart';

class ManiadbArtistUsecase {
  ManiadbArtistUsecase(this._maniadbRepository);
  final ManiadbRepository _maniadbRepository;

  Future<List<ManiadbArtistEntity>?> execute(String query) async{
    return await _maniadbRepository.fetchArtist(query);
  }

}

final maniadbArtistUsecaseProvider = Provider<ManiadbArtistUsecase>((ref){
  final maniadbDataSource = ManiadbDataSourceImpl();
  final maniadbRepository = ManiadbRepositoryImpl(maniadbDataSource);
  return ManiadbArtistUsecase(maniadbRepository);
});
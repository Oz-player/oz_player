import 'package:oz_player/data/source/naver/naver_search_data_source.dart';
import 'package:oz_player/domain/entitiy/naver_entity.dart';
import 'package:oz_player/domain/repository/naver_repository.dart';

class NaverRepositoryImpl implements NaverRepository{
  NaverRepositoryImpl(this._naverSearchDataSource);
  final NaverSearchDataSource _naverSearchDataSource;

  @override
  Future<List<NaverEntity>?> fetchNaver(String query) async{
    final result = await _naverSearchDataSource.fetchNaver(query);
    return result
        .map(
          (e) => NaverEntity(
            title: e.title,
            artist: e.artist,
            lyrics: e.lyrics,
            link: e.link,
          ),
        )
        .toList();
  }
  
}
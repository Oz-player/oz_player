import 'package:oz_player/domain/entitiy/naver_entity.dart';
import 'package:oz_player/domain/repository/naver_repository.dart';

class NaverUsecase {
  NaverUsecase(this._naverRepository);
  final NaverRepository _naverRepository;

  Future<List<NaverEntity>?> naverExecute(String query) async{
    return await _naverRepository.fetchNaver(query);
  }
}
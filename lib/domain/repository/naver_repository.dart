import 'package:oz_player/domain/entitiy/naver_entity.dart';

abstract interface class NaverRepository {
  Future<List<NaverEntity>?> fetchNaver(String query);
}
import 'package:oz_player/data/dto/naver_search_dto.dart';

abstract interface class NaverSearchDataSource {
  Future<List<NaverSearchDto>> fetchNaver(String query);
}
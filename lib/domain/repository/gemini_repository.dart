import 'package:oz_player/domain/entitiy/recommend_music_entity.dart';

abstract class GeminiRepository {
  Future<RecommendMusicEntity> recommentMusicByGemini(String condition, String apiKey);
  Future<List<RecommendMusicEntity>> recommentMultiMusicByGemini(String condition, String apiKey, int num, String except);
}
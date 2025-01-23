import 'package:oz_player/data/dto/recommend_music_dto.dart';

abstract class AiSource {
  Future<RecommendMusicDto> getResponse(String prompt, String apiKey);
  Future<List<RecommendMusicDto>> getMultiResponse(String prompt, String apiKey);
}
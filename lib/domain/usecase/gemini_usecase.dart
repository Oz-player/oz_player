import 'package:oz_player/domain/entitiy/recommend_music_entity.dart';
import 'package:oz_player/domain/repository/gemini_repository.dart';

class GeminiUsecase {
  GeminiUsecase(this._geminiRepository);
  final GeminiRepository _geminiRepository;

  Future<RecommendMusicEntity> recommentMusicByGemini(String condition, String apiKey) async {
    final result = await _geminiRepository.recommentMusicByGemini(condition, apiKey);
    return result;
  }
}
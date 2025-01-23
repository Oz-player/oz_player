import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/recommend_music_entity.dart';
import 'package:oz_player/domain/repository/gemini_repository.dart';
import 'package:oz_player/presentation/providers/login/providers.dart';

class GeminiUsecase {
  GeminiUsecase(this._geminiRepository);
  final GeminiRepository _geminiRepository;

  /// Gemini 에게 음악 추천을 받는 메서드
  /// condition 에 추천받고 싶은 음악의 조건을 넣으면
  /// 노래 이름과 아티스트 정보를 출력한다.
  /// (아직 프롬프트 수정 필요) 
  Future<RecommendMusicEntity> recommentMusicByGemini(String condition, String apiKey) async {
    final result = await _geminiRepository.recommentMusicByGemini(condition, apiKey);
    return result;
  }

  /// Gemini 에게 음악 추천을 받는 메서드 (복수 출력)
  /// condition 에 추천받고 싶은 음악의 조건을 넣으면
  /// 노래 이름과 아티스트 정보를 출력한다.
  Future<List<RecommendMusicEntity>> recommentMultiMusicByGemini(String condition, String apiKey, int num) async {
    final result = await _geminiRepository.recommentMultiMusicByGemini(condition, apiKey, num);
    return result;
  }
}

final geminiUsecaseProvider = Provider<GeminiUsecase>((ref){
  final geminiRepository = ref.watch(geiminiRepositoryProvider);
  return GeminiUsecase(geminiRepository);
});
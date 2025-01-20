import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/data/dto/recommend_music_dto.dart';
import 'package:oz_player/data/source/gemini_source_impl.dart';

abstract class AiSource {
  Future<RecommendMusicDto> getResponse(String prompt, String apiKey);
}

final aiSourceProvider = Provider<AiSource>((ref){
  return GeminiSourceImpl();
});
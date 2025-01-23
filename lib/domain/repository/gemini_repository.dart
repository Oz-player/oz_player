import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/data/repository_impl/gemini_repository_impl.dart';
import 'package:oz_player/data/source/ai_source.dart';
import 'package:oz_player/domain/entitiy/recommend_music_entity.dart';

abstract class GeminiRepository {
  Future<RecommendMusicEntity> recommentMusicByGemini(String condition, String apiKey);
  Future<List<RecommendMusicEntity>> recommentMultiMusicByGemini(String condition, String apiKey, int num);
}

final geiminiRepositoryProvider = Provider<GeminiRepository>((ref){
  final aiSource = ref.watch(aiSourceProvider);
  return GeminiRepositoryImpl(aiSource);
});
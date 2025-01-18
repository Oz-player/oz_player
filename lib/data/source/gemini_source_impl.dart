import 'dart:convert';
import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:oz_player/data/dto/recommend_music_dto.dart';
import 'package:oz_player/data/source/ai_source.dart';

class GeminiSourceImpl implements AiSource {
  @override
  Future<RecommendMusicDto> getResponse(String prompt, String apiKey) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      final filteringText = response.text!.split('json')[1].split('```')[0];
      Map<String,dynamic> data = jsonDecode(filteringText);
      return RecommendMusicDto.fromJson(data);
    } catch (e) {
      log('추천음악 GEMINI 응답 실패');
      return RecommendMusicDto.empty();
    }
  }
}

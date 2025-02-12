import 'dart:convert';
import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:oz_player/data/dto/recommend_music_dto.dart';
import 'package:oz_player/data/source/ai_source.dart';

class GeminiSourceImpl implements AiSource {

  @override
  Future<RecommendMusicDto> getResponse(String prompt, String apiKey) async {
    try {
      log('GEMINI 추천 시작');
      
      final model = GenerativeModel(
        model: 'gemini-1.5-pro-latest',
        apiKey: apiKey,
        generationConfig: GenerationConfig(temperature: 1.3),
      );

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      log(response.text!);

      log('추천음악 GEMINI 응답 성공');
      final filteringText = response.text!.split('json')[1].split('```')[0];

      Map<String, dynamic> data = jsonDecode(filteringText);
      return RecommendMusicDto.fromJson(data);
    } catch (e) {
      log('추천음악 GEMINI 응답 실패');
      return RecommendMusicDto.empty();
    }
  }

  @override
  Future<List<RecommendMusicDto>> getMultiResponse(
      String prompt, String apiKey) async {
    try {
      log('GEMINI 추천 시작');
      
      final model = GenerativeModel(
        model: 'gemini-1.5-pro-latest',
        apiKey: apiKey,
        generationConfig: GenerationConfig(temperature: 1.3),
      );
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      log(response.text!);

      log('추천음악 GEMINI 응답 성공');
      final filteringText = response.text!.split('json')[1].split('```')[0];
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(jsonDecode(filteringText));

      final list = data.map((e) {
        return RecommendMusicDto.fromJson(e);
      }).toList();

      return list;
    } catch (e) {
      log('추천음악 GEMINI 응답 실패 $e');
      return [];
    }
  }
}

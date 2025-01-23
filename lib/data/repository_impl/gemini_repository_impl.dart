import 'package:oz_player/data/source/ai_source.dart';
import 'package:oz_player/domain/entitiy/recommend_music_entity.dart';
import 'package:oz_player/domain/repository/gemini_repository.dart';

class GeminiRepositoryImpl implements GeminiRepository {
  GeminiRepositoryImpl(this._aiSource);
  final AiSource _aiSource;

  @override
  Future<RecommendMusicEntity> recommentMusicByGemini(String condition, String apiKey) async {
    final prompt = '''
다음 조건을 만족하는 노래 하나를 추천해줘

$condition

답변은 오직 JSON 형식으로만 작성해 줘.

답변 예시는 다음과 같아
{
musicName : '노래제목',
artist : '가수이름',
}
''';

    final result = await _aiSource.getResponse(prompt, apiKey);
    return RecommendMusicEntity.fromRecommendMusicDto(result);
  }
  
  @override
  Future<List<RecommendMusicEntity>> recommentMultiMusicByGemini(String condition, String apiKey, int num) async {
        final prompt = '''
아래 상황에 들을 수 있을만한 노래를 $num개 정도 추천해줘

$condition

답변은 오직 JSON 형식으로만 작성해 줘.

답변 예시는 다음과 같아
{
musicName : '노래제목',
artist : '가수이름',
}
''';

    final result = await _aiSource.getMultiResponse(prompt, apiKey);
    final newResult = result.map((e){
      return RecommendMusicEntity.fromRecommendMusicDto(e);
    }).toList();

    return newResult;
  }
  
}

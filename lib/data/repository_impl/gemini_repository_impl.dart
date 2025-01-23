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
  Future<List<RecommendMusicEntity>> recommentMultiMusicByGemini(String condition, String apiKey, int num, String except) async {
        final prompt = '''
아래 조건에 맞는 실제로 존재하는 노래를 최대 $num곡 추천해줘.  
$condition
5. 반드시 존재하는 노래만 추천해야 함.  
6. 조건에 맞는 곡이 $num개 미만이어도 괜찮으며, 조건에 맞는 곡만 최대 $num곡까지 추천할 것.  
7. 한국곡 추천을 우선으로 하되, 전 세계 다양한 나라의 곡들이 추천되도록 할 것.  
8. 다음곡들은 추천에서 제외할것
$except

응답할때 값은 다음 조건에 맞아야 함
1. musicName엔 '가수 - 노래제목' 으로 출력되어야 함 
2. 응답형식은 다음과 같아야 함
응답 형식:
[
  {
    "musicName": "가수 - 노래제목"
  }
]
''';

    final result = await _aiSource.getMultiResponse(prompt, apiKey);
    final newResult = result.map((e){
      return RecommendMusicEntity.fromRecommendMusicDto(e);
    }).toList();

    return newResult;
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oz_player/data/repository_impl/gemini_repository_impl.dart';
import 'package:oz_player/data/source/gemini_source_impl.dart';
import 'package:oz_player/domain/usecase/gemini_usecase.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  test('env Load', () {
    expect(dotenv.env['TEST_KEY'], 'Test_1234');
  });

  test('GEMINI RESPONDSE TEST', () async {
    final dataSource = GeminiSourceImpl();
    final repository = GeminiRepositoryImpl(dataSource);
    final geminiUsecase = GeminiUsecase(repository);

    final apiKey = dotenv.env['GEMINI_KEY'];
    final condition = '''
1. 2020년대 노래
2. 발라드
''';

    final result =
        await geminiUsecase.recommentMusicByGemini(condition, apiKey!);
    debugPrint('musicName : ${result.musicName}');
    debugPrint('artist : ${result.artist}');

    expect(result.musicName != null, true);
  });

  test('GEMINI MULTI TEST', () async {
    final dataSource = GeminiSourceImpl();
    final repository = GeminiRepositoryImpl(dataSource);
    final geminiUsecase = GeminiUsecase(repository);

    final apiKey = dotenv.env['GEMINI_KEY'];
    final num = 5;
    final condition = '''
1. 지금 나의 기분은 '위로가 필요해요, 혼란스러워요'
2. 지금 내가 하고 있는것은 '산책'
3. 추천 받고 싶은 노래의 장르는 '발라드'
4. 선호하는 아티스트는 '여성 솔로'
''';

    final except = '''
''';

    final result = await geminiUsecase.recommentMultiMusicByGemini(condition, apiKey!, num, except);
    debugPrint('musicName : ${result[0].musicName}');
    debugPrint('artist : ${result[0].artist}');

    expect(result.isNotEmpty, true);
  });
}

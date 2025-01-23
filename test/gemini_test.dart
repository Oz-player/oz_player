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
1. 위로가 필요할때 들을수 있는 노래
2. 공부, 집중할때 들을 수 있는 노래
3. 장르는 되도록 발라드
''';

    final result = await geminiUsecase.recommentMultiMusicByGemini(condition, apiKey!, num);
    debugPrint('musicName : ${result[0].musicName}');
    debugPrint('artist : ${result[0].artist}');

    expect(result.isNotEmpty, true);
  });
}

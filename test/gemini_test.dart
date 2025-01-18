import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oz_player/data/repository_impl/gemini_repository_impl.dart';
import 'package:oz_player/data/source/gemini_source_impl.dart';
import 'package:oz_player/domain/usecase/gemini_usecase.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  test('env Load', (){
    expect(dotenv.env['TEST_KEY'],'Test_1234');
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

    final result = await geminiUsecase.recommentMusicByGemini(condition, apiKey!);
    print('${result.musicName}');
    print('${result.artist}');

    expect(result.musicName != null, true);
  });
}

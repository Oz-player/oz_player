import 'dart:convert';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:oz_player/data/dto/naver_search_dto.dart';
import 'package:oz_player/data/source/naver/naver_search_data_source.dart';

class NaverSearchDataSourceImpl implements NaverSearchDataSource {
  @override
  Future<List<NaverSearchDto>> fetchNaver(String query) async {
    final client = Client();
    try {
      final response = await client.get(
        Uri.parse(
          'https://m.search.naver.com/p/csearch/content/qapirender.nhn?where=nexearch&key=LyricsSearchResult&q=가사검색$query',
        ),
      );

      if (response.statusCode == 200) {
        // Response body 디코딩
        final Map<String, dynamic> map = jsonDecode(response.body);

        // 데이터에서 필요한 필드 추출
        final htmlContent = map['current']['html'].toString();

        // HTML 파싱 및 필요한 데이터 추출
        final parsedData = parseHtml(htmlContent);

        return parsedData;
      } else {
        // 실패한 경우 빈 리스트 반환
        return [];
      }
    } catch (e) {
      // 오류 처리 (네트워크 에러 등)
      print('Error fetching data: $e');
      return [];
    } finally {
      client.close();
    }
  }

  // HTML 데이터를 파싱하고 DTO 리스트로 변환
  List<NaverSearchDto> parseHtml(String html) {
    final document = parse(html);

    // 각 노래 데이터를 파싱하여 리스트 생성
    final elements = document.querySelectorAll('.result_list_box ._li');
    return elements.map((element) {
      final title = element.querySelector('.music_title a')?.text ?? '제목 없음';
      final artist = element.querySelector('.sub_text')?.text ?? '아티스트 없음';
      final lyricsElement = element.querySelector('.lyrics');
      final lyrics = lyricsElement != null ? lyricsElement.innerHtml : '가사 없음';
      final link = element.querySelector('.music_title a')?.attributes['href'] ?? '';

      return NaverSearchDto(
        title: title,
        artist: artist,
        lyrics: lyrics,
        link: link,
      );
    }).toList();
  }
}

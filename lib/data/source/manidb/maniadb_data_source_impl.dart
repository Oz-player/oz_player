import 'dart:convert';
import 'package:oz_player/data/dto/mania/maniadb_artist_dto.dart';
import 'package:oz_player/data/dto/mania/maniadb_song_dto.dart';
import 'package:oz_player/data/source/manidb/maniadb_data_source.dart';
import 'package:http/http.dart';
import 'package:xml2json/xml2json.dart';

class ManiadbDataSourceImpl implements ManiadbDataSource {
  final Xml2Json xml2json = Xml2Json();


  @override
  Future<List<ManiadbArtistDto>> fetchArtist(String query) async {
    final client = Client();
    final response = await client.get(
      Uri.parse(
        'http://www.maniadb.com/api/search/$query/?sr=artist&display=1&key=example&v=0.5',
      ),
    );

    if (response.statusCode == 200) {
      xml2json.parse(response.body);
      var jsonData = xml2json.toParker();

      Map<String, dynamic> map = jsonDecode(jsonData);
      final dynamic itemData = map['rss']['channel']['item'];

      // item이 단일 객체일 경우와 리스트일 경우를 구분
      final results = (itemData is List)
          ? List.from(itemData)
          : [itemData]; // 단일 객체라면 리스트로 감싸줌

      final iterable = results.map((e) => ManiadbArtistDto.fromJson(e));
      final list = iterable.toList();
      return list;
    }
    return [];
  }

  @override
  Future<List<ManiadbSongDto>> fetchSong(String query) async{
    final client = Client();
    final response = await client.get(
      Uri.parse(
        'http://www.maniadb.com/api/search/$query/?sr=song&display=1&key=example&v=0.5',
      ),
    );

    if (response.statusCode == 200) {
      xml2json.parse(response.body);
      var jsonData = xml2json.toParker();

      Map<String, dynamic> map = jsonDecode(jsonData);
      final dynamic itemData = map['rss']['channel']['item'];

      // item이 단일 객체일 경우와 리스트일 경우를 구분
      final results = (itemData is List)
          ? List.from(itemData)
          : [itemData]; // 단일 객체라면 리스트로 감싸줌

      final iterable = results.map((e) => ManiadbSongDto.fromJson(e));
      final list = iterable.toList();
      return list;
    }
    return [];
  }
}

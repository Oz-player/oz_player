import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:oz_player/data/dto/spotify_dto.dart';
import 'package:oz_player/data/source/spotify/spotify_data_source.dart';

class SpotifyDataSourceImpl implements SpotifyDataSource {

  String? _token;
  DateTime? _tokenExpiration;

  // 토큰을 요청하는 메서드
  Future<void> _fetchToken() async {
    final client = Client();
    final response = await client.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
        'client_id': dotenv.get('CLIENT_ID'),
        'client_secret': dotenv.get('CLIENT_SECRET'),
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> tokenData = jsonDecode(response.body);
      _token = tokenData['access_token'];
      // 토큰의 유효 기간을 설정 (1시간 후)
      _tokenExpiration = DateTime.now().add(Duration(hours: 1));
    } else {
      throw Exception('Failed to fetch token');
    }
  }

  // 토큰이 유효한지 확인하고 필요 시 새로 요청
  Future<String> _getToken() async {
    if (_token == null || _tokenExpiration!.isBefore(DateTime.now())) {
      await _fetchToken();
    }
    return _token!;
  }


  @override
  Future<List<SpotifyDto>> searchList(String query) async {
    final client = Client();
    final token = await _getToken();
    final response = await client.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$query&type=track&locale=ko-KR'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> map = jsonDecode(response.body);
      List<SpotifyDto> list = [];

      // tracks
      if (map['tracks'] != null) {
        final trackResults = map['tracks']['items'] as List;
        for (var track in trackResults) {
          list.add(SpotifyDto.fromJson(track));
        }
      }

      // artists
      if (map['artists'] != null) {
        final artistResults = map['artists']['items']as List;
        for (var artist in artistResults) {
          list.add(SpotifyDto.fromJson(artist));
        }
      }

      return list;
    }
    return [];
  }
}

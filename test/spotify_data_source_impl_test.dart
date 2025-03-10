import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oz_player/data/source/spotify/spotify_data_source_impl.dart';

void main() {
  test('spotify test', () async {
    await dotenv.load(fileName: ".env");
    SpotifyDataSourceImpl spotifyDataSourceImpl = SpotifyDataSourceImpl();
    final search = await spotifyDataSourceImpl.searchList('abc');
    expect(search.isEmpty, false);
    log('${search.length}');
    for (var searchs in search) {
      log("id : ${searchs.id}");
      log("name : ${searchs.name}");
      log("type : ${searchs.type}");
      log("uri : ${searchs.uri}");
      log("popularity : ${searchs.popularity}");
      log("genres : ${searchs.genres}");
      log("images : ${searchs.images}");
      log("durationMs : ${searchs.durationMs}");
      log("iexplicit : ${searchs.explicit}");
      log("previewUrl : ${searchs.previewUrl}");
      log("album : ${searchs.album}");
      log("album_artist_name : ${searchs.album?['artists'][0]['name']}");
      log("album_images : ${searchs.album?['images'][0]['url']}");
    }
  });
}

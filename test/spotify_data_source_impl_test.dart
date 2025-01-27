import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oz_player/data/source/spotify/spotify_data_source_impl.dart';

void main() {
  test('spotify test', () async {
    await dotenv.load(fileName: ".env");
    SpotifyDataSourceImpl spotifyDataSourceImpl = SpotifyDataSourceImpl();
    final search = await spotifyDataSourceImpl.searchList('love wins all');
    expect(search.isEmpty, false);
    print(search.length);
    for (var searchs in search) {
      print("id : ${searchs.id}");
      print("name : ${searchs.name}");
      print("type : ${searchs.type}");
      print("uri : ${searchs.uri}");
      print("popularity : ${searchs.popularity}");
      print("genres : ${searchs.genres}");
      print("images : ${searchs.images}");
      print("durationMs : ${searchs.durationMs}");
      print("iexplicit : ${searchs.explicit}");
      print("previewUrl : ${searchs.previewUrl}");
      print("album : ${searchs.album}");
    }
  });
}

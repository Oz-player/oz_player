import 'package:flutter_test/flutter_test.dart';
import 'package:oz_player/data/source/manidb/maniadb_data_source_impl.dart';

void main() {
  test('test fetchArtist', () async{
    ManiadbDataSourceImpl maniadbDataSourceImpl = ManiadbDataSourceImpl();
    final search = await maniadbDataSourceImpl.fetchArtist('백예린');
    expect(search.isEmpty, false);
    for (var search in search) {
      print(search.title);
      print(search.majorSongList);
      print(search.image);
      
    }
  });

  test('test fetchSong', () async{
    ManiadbDataSourceImpl maniadbDataSourceImpl = ManiadbDataSourceImpl();
    final searchone = await maniadbDataSourceImpl.fetchSong('bye bye my blue');
    expect(searchone.isEmpty, false);
    for (var searchs in searchone) {
      print("title : ${searchs.title}");
      print("album : ${searchs.album['title']}");
      print("artist : ${searchs.artist}");
      print("comments : ${searchs.comments}");
      print("description : ${searchs.description}");
      print("link : ${searchs.link}");
      print("link : ${searchs.pubDate}");
      print("----------------------");
    }
  });
}
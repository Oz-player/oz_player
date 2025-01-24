import 'package:flutter_test/flutter_test.dart';
import 'package:oz_player/data/source/manidb/maniadb_data_source_impl.dart';

void main() {
  test('test fetchArtist', () async{
    ManiadbDataSourceImpl maniadbDataSourceImpl = ManiadbDataSourceImpl();
    final search = await maniadbDataSourceImpl.fetchArtist('백예린');
    expect(search.isEmpty, false);
    for (var search in search) {
      print('majorSongs: ${search.majorSongs['merchants']}');
    }
  });

  test('test fetchSong', () async{
    ManiadbDataSourceImpl maniadbDataSourceImpl = ManiadbDataSourceImpl();
    final searchone = await maniadbDataSourceImpl.fetchSong('bye bye my blue');
    expect(searchone.isEmpty, false);
    for (var searchs in searchone) {
      print("id : ${searchs.id}");
      print("title : ${searchs.title}");
      print("runningTime : ${searchs.runningTime}");
      print("link : ${searchs.link}");
      print("pubdate : ${searchs.pubDate}");
      print("author : ${searchs.author}");
      print("description : ${searchs.description}");
      print("comments : ${searchs.comments}");
      print("album : ${searchs.album}");
      print("artist : ${searchs.artist}");
      print("----------------------");
    }
  });
}
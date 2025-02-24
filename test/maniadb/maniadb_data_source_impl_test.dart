import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:oz_player/data/source/manidb/maniadb_data_source_impl.dart';

void main() {
  test('test fetchArtist', () async {
    ManiadbDataSourceImpl maniadbDataSourceImpl = ManiadbDataSourceImpl();
    final search = await maniadbDataSourceImpl.fetchArtist('백예린');
    expect(search.isEmpty, false);
    for (var search in search) {
      log('majorSongs: ${search.majorSongs['merchants']}');
    }
  });

  test('test fetchSong', () async {
    ManiadbDataSourceImpl maniadbDataSourceImpl = ManiadbDataSourceImpl();
    final searchone = await maniadbDataSourceImpl.fetchSong('bye bye my blue');
    expect(searchone.isEmpty, false);
    for (var searchs in searchone) {
      log("id : ${searchs.id}");
      log("title : ${searchs.title}");
      log("runningTime : ${searchs.runningTime}");
      log("link : ${searchs.link}");
      log("pubdate : ${searchs.pubDate}");
      log("author : ${searchs.author}");
      log("description : ${searchs.description}");
      log("comments : ${searchs.comments}");
      log("album : ${searchs.album}");
      log("artist : ${searchs.artist}");
      log("----------------------");
    }
  });
}

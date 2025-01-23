import 'package:flutter_test/flutter_test.dart';
import 'package:oz_player/data/source/manidb/maniadb_data_source_impl.dart';

void main() {
  test('test fetchArtist', () async{
    ManiadbDataSourceImpl maniadbDataSourceImpl = ManiadbDataSourceImpl();
    final search = await maniadbDataSourceImpl.fetchArtist('아이유');
    expect(search.isEmpty, false);
    for (var search in search) {
      print(search.title);
      print(search.majorSongList);
      print(search.image);
      
    }
  });

  test('test fetchSong', () async{
    ManiadbDataSourceImpl maniadbDataSourceImpl = ManiadbDataSourceImpl();
    final search = await maniadbDataSourceImpl.fetchSong('사랑');
    expect(search.isEmpty, false);
    for (var search in search) {
      print(search.title);
      
    }
  });
}
import 'package:flutter_test/flutter_test.dart';
import 'package:oz_player/data/repository_impl/maniadb_repository_impl.dart';
import 'package:oz_player/data/source/manidb/maniadb_data_source_impl.dart';
import 'package:oz_player/domain/usecase/maniadb/maniadb_artist_usecase.dart';
import 'package:oz_player/domain/usecase/maniadb/maniadb_song_usecase.dart';

void main() {
  test('test fetchArtist', () async {
    final maniadbDataSource = ManiadbDataSourceImpl();
    final maniadbRepository = ManiadbRepositoryImpl(maniadbDataSource);
    final maniadbUsecase = ManiadbArtistUsecase(maniadbRepository);

    final search = await maniadbUsecase.execute('아이유');
    expect(search!.isEmpty, false);
    for (var search in search) {
      print('title : ${search.title}');
      print('majorSongList : ${search.majorSongList}');
      print('imageUrl : ${search.image}');
      print('reference : ${search.reference}');
      print('majorSongs : ${search.majorSongs}');
      print('author : ${search.author}');
      print('demographic : ${search.demographic}');
      print('guid : ${search.guid}');
      print('linkDiscograpy : ${search.linkDiscography}');
    }
  });

  test('test fetchSong', () async {
    final maniadbDataSource = ManiadbDataSourceImpl();
    final maniadbRepository = ManiadbRepositoryImpl(maniadbDataSource);
    final maniadbUsecase = ManiadbSongUsecase(maniadbRepository);

    final search = await maniadbUsecase.execute('미운 오리');
    expect(search!.isEmpty, false);
    for (var search in search) {
      print('title : ${search.title}');
      print('artist : ${search.artist}');
      print('runningTime : ${search.runningTime}');
    }
  });
}

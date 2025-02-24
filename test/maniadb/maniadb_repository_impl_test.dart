import 'dart:developer';

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

    final search = await maniadbUsecase.execute('볼빨간사춘기');
    expect(search!.isEmpty, false);
    for (var search in search) {
      log('title : ${search.title}');
      log('majorSongList : ${search.majorSongList}');
      log('imageUrl : ${search.image}');
    }
    log(search[0].image);
  });

  test('test fetchSong', () async {
    final maniadbDataSource = ManiadbDataSourceImpl();
    final maniadbRepository = ManiadbRepositoryImpl(maniadbDataSource);
    final maniadbUsecase = ManiadbSongUsecase(maniadbRepository);

    final search = await maniadbUsecase.execute('미운 오리');
    expect(search!.isEmpty, false);
    for (var search in search) {
      log('title : ${search.title}');
      log('artist : ${search.artist['name']}');
    }
  });
}

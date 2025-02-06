import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/data/repository_impl/naver_repository_impl.dart';
import 'package:oz_player/data/repository_impl/spotify_repository_impl.dart';
import 'package:oz_player/data/source/naver/naver_search_data_source.dart';
import 'package:oz_player/data/source/naver/naver_search_data_source_impl.dart';
import 'package:oz_player/data/source/spotify/spotify_data_source.dart';
import 'package:oz_player/data/source/spotify/spotify_data_source_impl.dart';
import 'package:oz_player/domain/repository/naver_repository.dart';
import 'package:oz_player/domain/repository/spotify_repository.dart';
import 'package:oz_player/domain/usecase/naver_usecase.dart';
import 'package:oz_player/domain/usecase/spotify_usecase.dart';

final spotifyDataSourceProvider = Provider<SpotifyDataSource>((ref) {
  return SpotifyDataSourceImpl();
});

final spotifyRepositoryProvider = Provider<SpotifyRepository>((ref) {
  final dataSource = ref.read(spotifyDataSourceProvider);
  return SpotifyRepositoryImpl(dataSource);
});

final fetchSpotifyUsecaseProvider = Provider((ref) {
  final spofityRepo = ref.read(spotifyRepositoryProvider);
  return SpotifyUsecase(spofityRepo);
});



final naverDataSourceProvider = Provider<NaverSearchDataSource>((ref) {
  return NaverSearchDataSourceImpl();
});

final naverRepositoryProvider = Provider<NaverRepository>((ref) {
  final dataSource = ref.read(naverDataSourceProvider);
  return NaverRepositoryImpl(dataSource);
});

final fetchNaverUsecaseProvider = Provider((ref) {
  final naverRepo = ref.read(naverRepositoryProvider);
  return NaverUsecase(naverRepo);
});

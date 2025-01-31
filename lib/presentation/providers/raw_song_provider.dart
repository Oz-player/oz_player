import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/data/repository_impl/raw_song_repository_impl.dart';
import 'package:oz_player/data/source/saved/raw_song_source_impl.dart';
import 'package:oz_player/domain/usecase/raw_song_usecase.dart';

final _rawSongSourceProvider = Provider((ref) {
  return RawSongSourceImpl(FirebaseFirestore.instance);
});

final _rawSongRepositoryProvider = Provider((ref) {
  return RawSongRepositoryImpl(ref.read(_rawSongSourceProvider));
});

final rawSongUsecaseProvider = Provider((ref) {
  return RawSongUsecase(ref.read(_rawSongRepositoryProvider));
});

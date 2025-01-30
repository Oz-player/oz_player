import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/data/repository_impl/song_repository_impl.dart';
import 'package:oz_player/data/source/saved/raw_song_source_impl.dart';
import 'package:oz_player/domain/usecase/song_usecase.dart';

final _firebaseSongSourceProvider = Provider((ref) {
  return RawSongSourceImpl(FirebaseFirestore.instance);
});

final _songRepositoryProvider = Provider((ref) {
  return SongRepositoryImpl(ref.read(_firebaseSongSourceProvider));
});

final songUsecaseProvider = Provider((ref) {
  return SongUsecase(ref.read(_songRepositoryProvider));
});

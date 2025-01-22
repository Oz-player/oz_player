import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/data/repository_impl/play_list_repository_impl.dart';
import 'package:oz_player/data/source/firebase/play_list_source_impl.dart';
import 'package:oz_player/data/source/play_list/play_list_source.dart';
import 'package:oz_player/domain/repository/play_list_repository.dart';
import 'package:oz_player/domain/usecase/play_list_usecase.dart';

final _playListSourceProvider = Provider<PlayListSource>((ref) {
  return PlayListSourceImpl(FirebaseFirestore.instance);
});

final _playListRepositoryProvider = Provider<PlayListRepository>((ref) {
  return PlayListRepositoryImpl(ref.watch(_playListSourceProvider));
});

final playListsUsecaseProvider = Provider((ref) {
  return PlayListUsecase(ref.watch(_playListRepositoryProvider));
});

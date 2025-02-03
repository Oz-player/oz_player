import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/data/repository_impl/library_repository_impl.dart';
import 'package:oz_player/data/source/saved/library_source_impl.dart';
import 'package:oz_player/domain/usecase/library_usecase.dart';
import 'package:oz_player/presentation/view_model/user_view_model.dart';

final _librarySourceProvider = Provider((ref) {
  return LibrarySourceImpl(FirebaseFirestore.instance);
});

final _libraryRepositoryProvider = Provider((ref) {
  return LibraryRepositoryImpl(ref.watch(_librarySourceProvider));
});

final libraryUsecaseProvider = Provider((ref) {
  return LibraryUsecase(
    ref.watch(_libraryRepositoryProvider),
    ref.read(userViewModelProvider.notifier).getUserId(),
  );
});

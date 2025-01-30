import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/presentation/providers/library_provider.dart';

class LibraryViewModel extends AsyncNotifier<List<LibraryEntity>> {
  @override
  FutureOr<List<LibraryEntity>> build() async {
    return [];
  }

  Future<void> getLibrary() async {
    state = const AsyncValue.loading();
    state =
        AsyncValue.data(await ref.read(libraryUsecaseProvider).getLibrary());
  }
}

final libraryViewModelProvider =
    AsyncNotifierProvider<LibraryViewModel, List<LibraryEntity>>(
  () => LibraryViewModel(),
);

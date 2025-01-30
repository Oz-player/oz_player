import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/presentation/providers/library_provider.dart';
import 'package:oz_player/presentation/view_model/user_view_model.dart';

class LibraryViewModel extends AsyncNotifier<List<LibraryEntity>> {
  late final String userId;

  @override
  FutureOr<List<LibraryEntity>> build() async {
    ref.read(userViewModelProvider.notifier).getUserId();
    return [];
  }

  Future<void> getLibrary() async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(
        await ref.read(libraryUsecaseProvider).getLibrary(userId));
  }
}

final libraryViewModelProvider =
    AsyncNotifierProvider<LibraryViewModel, List<LibraryEntity>>(
  () => LibraryViewModel(),
);

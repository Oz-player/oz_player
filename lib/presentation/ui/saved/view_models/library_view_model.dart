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

  // 라이브러리를 최근 저장 순으로 정렬
  void getLibraryLatest() {
    if (state.value == null) return;
    state = AsyncValue.data([...state.value!]..sort((a, b) {
        return b.createdAt.compareTo(a.createdAt);
      }));
  }

  // 라이브러리를 가나다순으로 정렬
  void getLibraryAscending() {
    if (state.value == null) return;
    state = AsyncValue.data([...state.value!]..sort((a, b) {
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      }));
  }
}

final libraryViewModelProvider =
    AsyncNotifierProvider<LibraryViewModel, List<LibraryEntity>>(
  () => LibraryViewModel(),
);

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/presentation/providers/play_list_provider.dart';
import 'package:oz_player/presentation/view_model/user_view_model.dart';

class PlaylistViewModel extends AsyncNotifier<List<PlayListEntity>> {
  @override
  FutureOr<List<PlayListEntity>> build() {
    return [];
  }

  // DB에서 플레이리스트 추출
  Future<void> getPlayLists() async {
    print('view: ${ref.watch(userViewModelProvider.notifier).getUserId()}');
    state = AsyncValue.data(await ref
        .read(playListsUsecaseProvider)
        .getPlayLists(ref.read(userViewModelProvider.notifier).getUserId()));
  }

  // 플레이리스트를 최근 저장 순으로 정렬
  void getPlayListsLatest() {
    if (state.value == null) return;
    state = AsyncValue.data([...state.value!]..sort((a, b) {
        return b.createdAt.compareTo(a.createdAt);
      }));
  }

  // 플레이리스트를 가나다순으로 정렬
  void getPlayListsAscending() {
    if (state.value == null) return;
    state = AsyncValue.data([...state.value!]..sort((a, b) {
        return a.listName.toLowerCase().compareTo(b.listName.toLowerCase());
      }));
  }

  Future<PlayListEntity?> getPlayList(String listName) async {
    return await ref.read(playListsUsecaseProvider).getPlayList(
        ref.read(userViewModelProvider.notifier).getUserId(), listName);
  }
}

final playListViewModelProvider =
    AsyncNotifierProvider<PlaylistViewModel, List<PlayListEntity>>(
  () => PlaylistViewModel(),
);

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/presentation/providers/play_list_provider.dart';

class PlaylistViewModel extends AsyncNotifier<List<PlayListEntity>> {
  @override
  FutureOr<List<PlayListEntity>> build() {
    return [];
  }

  Future<void> getPlayLists() async {
    state = AsyncValue.data(
        await ref.read(playListsUsecaseProvider).getPlayLists());
  }

  Future<PlayListEntity?> getPlayList(String listName) async {
    return await ref.read(playListsUsecaseProvider).getPlayList(listName);
  }
}

final playListViewModelProvider =
    AsyncNotifierProvider<PlaylistViewModel, List<PlayListEntity>>(
  () => PlaylistViewModel(),
);

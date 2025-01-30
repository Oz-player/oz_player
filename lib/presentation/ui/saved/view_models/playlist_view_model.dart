import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/presentation/providers/play_list_provider.dart';
import 'package:oz_player/presentation/view_model/user_view_model.dart';

class PlaylistViewModel extends AsyncNotifier<List<PlayListEntity>> {
  late final String userId;

  @override
  FutureOr<List<PlayListEntity>> build() {
    ref.read(userViewModelProvider.notifier).getUserId();
    return [];
  }

  Future<void> getPlayLists() async {
    state = AsyncValue.data(
        await ref.read(playListsUsecaseProvider).getPlayLists(userId));
  }
}

final playListViewModelProvider =
    AsyncNotifierProvider<PlaylistViewModel, List<PlayListEntity>>(
  () => PlaylistViewModel(),
);

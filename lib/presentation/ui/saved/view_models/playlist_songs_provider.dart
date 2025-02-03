import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/providers/song_provider.dart';

class PlaylistSongsNotifier extends AsyncNotifier<List<SongEntity>> {
  @override
  FutureOr<List<SongEntity>> build() {
    return [];
  }

  Future<void> loadSongs(List<String> songIds) async {
    state =
        AsyncValue.data(await ref.watch(songUsecaseProvider).getSongs(songIds));
  }
}

final playlistSongsProvider =
    AsyncNotifierProvider<PlaylistSongsNotifier, List<SongEntity>>(
  () => PlaylistSongsNotifier(),
);

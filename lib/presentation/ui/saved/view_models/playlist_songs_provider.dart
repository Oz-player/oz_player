import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/presentation/providers/raw_song_provider.dart';

class PlaylistSongsNotifier extends AsyncNotifier<List<RawSongEntity>> {
  @override
  FutureOr<List<RawSongEntity>> build() {
    return [];
  }

  Future<void> loadSongs(List<String> songIds) async {
    state = AsyncValue.data(
        await ref.watch(rawSongUsecaseProvider).getRawSongs(songIds));
  }
}

final playlistSongsProvider =
    AsyncNotifierProvider<PlaylistSongsNotifier, List<RawSongEntity>>(
  () => PlaylistSongsNotifier(),
);

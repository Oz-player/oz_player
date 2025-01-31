import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/domain/usecase/raw_song_usecase.dart';
import 'package:oz_player/presentation/providers/raw_song_provider.dart';

class PlaylistSongsNotifier extends StateNotifier<List<RawSongEntity>> {
  PlaylistSongsNotifier(this.rawSongUsecase) : super([]);

  final RawSongUsecase rawSongUsecase;

  Future<void> loadSongs(List<String> songIds) async {
    state = await rawSongUsecase.getRawSongs(songIds);
  }
}

final playlistSongsProvider = StateNotifierProvider.family<
    PlaylistSongsNotifier, List<RawSongEntity>, List<String>>(
  (ref, songIds) => PlaylistSongsNotifier(ref.watch(rawSongUsecaseProvider))
    ..loadSongs(songIds),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/domain/usecase/song_usecase.dart';
import 'package:oz_player/presentation/providers/song_provider.dart';

class LibrarySongsNotifier extends StateNotifier<List<SongEntity>> {
  LibrarySongsNotifier(this.songUsecase) : super([]);

  final SongUsecase songUsecase;

  Future<void> loadSongs(List<LibraryEntity> library) async {
    List<SongEntity> list = [];
    for (var item in library) {
      final song = await songUsecase.getSong(item.songId, item);
      if (song != null) list.add(song);
    }
    state = list;
  }
}

final librarySongsProvider = StateNotifierProvider.family<LibrarySongsNotifier,
    List<SongEntity>, List<LibraryEntity>>(
  (ref, library) =>
      LibrarySongsNotifier(ref.watch(songUsecaseProvider))..loadSongs(library),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/domain/entitiy/song_entitiy.dart';
import 'package:oz_player/presentation/providers/library_provider.dart';
import 'package:oz_player/presentation/providers/raw_song_provider.dart';

class SaveSongBottomSheetState {
  SongEntitiy? savedSong;
  int page;

  SaveSongBottomSheetState(this.savedSong, this.page);

  SaveSongBottomSheetState copyWith({
    SongEntitiy? savedSong,
    int? page,
  }) =>
      SaveSongBottomSheetState(savedSong ?? this.savedSong, page ?? this.page);
}

class SaveSongBottomSheetViewModel
    extends AutoDisposeNotifier<SaveSongBottomSheetState> {
  @override
  SaveSongBottomSheetState build() {
    return SaveSongBottomSheetState(null, 0);
  }

  void reflash() {
    state = state.copyWith();
  }

  /// 보관함에 저장할 곡을 세팅
  void setSaveSong(SongEntitiy song) {
    state.savedSong = song;
  }

  /// 보관함에 곡을 보내기 직전, memo 정보 추가
  void setMemoInSong(String memo) {
    state.savedSong!.memo = memo;
  }

  void saveSongInDBLibrary() {
    if (state.savedSong == null) return;
    final rawSongEntity = RawSongEntity(
      artist: state.savedSong!.artist,
      countLibrary: 0,
      countPlaylist: 0,
      video: state.savedSong!.video,
      title: state.savedSong!.title,
      imgUrl: state.savedSong!.imgUrl,
    );
    final libraryEntity = LibraryEntity(
      createdAt: DateTime.now(),
      favoriteArtist: state.savedSong!.favoriteArtist,
      genre: state.savedSong!.genre,
      memo: state.savedSong!.memo,
      mood: state.savedSong!.mood,
      situation: state.savedSong!.situation,
      songId: state.savedSong!.video.id,
    );
    ref.read(rawSongUsecaseProvider).updateRawSongByLibrary(rawSongEntity);
    ref.read(libraryUsecaseProvider).createLibrary(libraryEntity);
  }

  void saveSongInDBPlaylist() {}

  /// 음악카드 저장 프로세스 진행
  void nextPage() {
    state = state.copyWith(page: state.page + 1);
  }

  /// 페이지 초기화
  void resetPage() {
    state = state.copyWith(page: 0);
  }
}

final saveSongBottomSheetViewModelProvider = AutoDisposeNotifierProvider<
    SaveSongBottomSheetViewModel, SaveSongBottomSheetState>(() {
  return SaveSongBottomSheetViewModel();
});

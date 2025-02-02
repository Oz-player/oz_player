import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/providers/library_provider.dart';
import 'package:oz_player/presentation/providers/raw_song_provider.dart';
import 'package:oz_player/presentation/ui/saved/view_models/library_view_model.dart';

class SaveSongBottomSheetState {
  SongEntity? savedSong;
  int page;

  SaveSongBottomSheetState(this.savedSong, this.page);

  SaveSongBottomSheetState copyWith({
    SongEntity? savedSong,
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
  void setSaveSong(SongEntity song) {
    state.savedSong = song;
  }

  /// 보관함에 곡을 보내기 직전, memo 정보 추가
  void setMemoInSong(String memo) {
    state.savedSong!.memo = memo;
  }

  /// RawSong 객체 DB에 전송
  Future<void> saveSongInDB() async {
    if (state.savedSong == null) return;
    final rawSongEntity = RawSongEntity(
      artist: state.savedSong!.artist,
      countLibrary: 0,
      countPlaylist: 0,
      video: state.savedSong!.video,
      title: state.savedSong!.title,
      imgUrl: state.savedSong!.imgUrl,
    );
    await ref
        .read(rawSongUsecaseProvider)
        .updateRawSongByLibrary(rawSongEntity);
  }

  // Library 객체 DB에 전송
  Future<void> saveSongInLibrary() async {
    if (state.savedSong == null) return;
    final libraryEntity = LibraryEntity(
      createdAt: DateTime.now(),
      artist: state.savedSong!.artist,
      imgUrl: state.savedSong!.imgUrl,
      title: state.savedSong!.title,
      favoriteArtist: state.savedSong!.favoriteArtist,
      genre: state.savedSong!.genre,
      memo: state.savedSong!.memo,
      mood: state.savedSong!.mood,
      situation: state.savedSong!.situation,
      songId: state.savedSong!.video.id,
    );
    await ref.read(libraryUsecaseProvider).createLibrary(libraryEntity);
    await ref.read(libraryViewModelProvider.notifier).getLibrary();
  }

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

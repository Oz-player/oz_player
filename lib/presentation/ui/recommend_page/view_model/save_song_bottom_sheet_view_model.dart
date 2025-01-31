import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/song_entitiy.dart';

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

  void reflash(){
    state = state.copyWith();
  }

  /// 보관함에 저장할 곡을 세팅
  void setSaveSong(SongEntitiy song) {
    state.savedSong = song;
  }

  /// 보관함에 곡을 보내기 직전, memo 정보 추가
  void setMemoInSong(String memo){
    state.savedSong!.memo = memo;
  }

  /// 음악카드 저장 프로세스 진행
  void nextPage() {
    state = state.copyWith(page: state.page + 1);
  }

  /// 페이지 초기화
  void resetPage(){
    state = state.copyWith(page: 0);
  }
}

final saveSongBottomSheetViewModelProvider = AutoDisposeNotifierProvider<
    SaveSongBottomSheetViewModel, SaveSongBottomSheetState>(() {
  return SaveSongBottomSheetViewModel();
});

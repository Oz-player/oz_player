import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavePlaylistBottomSheetState {
  int? isClickedPlayList;
  bool blind;

  SavePlaylistBottomSheetState(this.isClickedPlayList, this.blind);

  SavePlaylistBottomSheetState copyWith({
    int? isClickedPlayList,
    bool? blind,
  }) =>
      SavePlaylistBottomSheetState(isClickedPlayList ?? this.isClickedPlayList, blind ?? this.blind);
}

class SavePlaylistBottomSheet
    extends AutoDisposeNotifier<SavePlaylistBottomSheetState> {
  @override
  SavePlaylistBottomSheetState build() {
    return SavePlaylistBottomSheetState(-1, false);
  }

  void isClickedPlayList(int index) {
    if (state.isClickedPlayList == index) {
      state = state.copyWith(isClickedPlayList: -1);
    } else {
      state = state.copyWith(isClickedPlayList: index);
    }
  }

  void isBlind(){
    state = state.copyWith(blind: true);
  }

  void reflash(){
    state = state.copyWith();
  }
}

final savePlaylistBottomSheetProvider = AutoDisposeNotifierProvider<
    SavePlaylistBottomSheet, SavePlaylistBottomSheetState>(() {
  return SavePlaylistBottomSheet();
});

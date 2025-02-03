import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavePlaylistBottomSheetState {
  int? isClickedPlayList;

  SavePlaylistBottomSheetState(this.isClickedPlayList);

  SavePlaylistBottomSheetState copyWith({
    int? isClickedPlayList,
  }) =>
      SavePlaylistBottomSheetState(isClickedPlayList ?? this.isClickedPlayList);
}

class SavePlaylistBottomSheet
    extends AutoDisposeNotifier<SavePlaylistBottomSheetState> {
  @override
  SavePlaylistBottomSheetState build() {
    return SavePlaylistBottomSheetState(-1);
  }

  void isClickedPlayList(int index) {
    if (state.isClickedPlayList == index) {
      state = state.copyWith(isClickedPlayList: -1);
    } else {
      state = state.copyWith(isClickedPlayList: index);
    }
  }
}

final savePlaylistBottomSheetProvider = AutoDisposeNotifierProvider<
    SavePlaylistBottomSheet, SavePlaylistBottomSheetState>(() {
  return SavePlaylistBottomSheet();
});

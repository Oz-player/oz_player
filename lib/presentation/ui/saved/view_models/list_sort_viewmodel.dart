import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/saved/view_models/library_view_model.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_view_model.dart';

enum SortedType {
  latest("최근 저장 순"),
  ascending("가나다순");

  final String stateString;
  const SortedType(this.stateString);
}

class ListSortViewmodel extends Notifier<SortedType> {
  @override
  SortedType build() {
    return SortedType.latest;
  }

  void setLatest() {
    state = SortedType.latest;
    ref.read(playListViewModelProvider.notifier).getPlayListsLatest();
    ref.read(libraryViewModelProvider.notifier).getLibraryLatest();
  }

  void setAscending() {
    state = SortedType.ascending;
    ref.read(playListViewModelProvider.notifier).getPlayListsAscending();
    ref.read(libraryViewModelProvider.notifier).getLibraryAscending();
  }
}

final listSortViewModelProvider =
    NotifierProvider<ListSortViewmodel, SortedType>(
  () => ListSortViewmodel(),
);

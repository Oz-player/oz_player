// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
// import 'package:oz_player/presentation/providers/raw_song_provider.dart';

// class RawSongViewModel extends AutoDisposeNotifier<List<RawSongEntity?>> {
//   @override
//   List<RawSongEntity?> build() {
//     return [];
//   }

//   Future<void> getRawSongs(List<String> songIds) async {
//     final usecase = ref.read(rawSongUsecaseProvider);
//     List<RawSongEntity?> list = [];

//     songIds.map((e) async {
//       list.add(await usecase.getRawSong(e));
//     });
//     state = list;
//   }
// }

// final rawSongViewModelProvider =
//     AutoDisposeNotifierProvider<RawSongViewModel, List<RawSongEntity?>>(
//   () => RawSongViewModel(),
// );

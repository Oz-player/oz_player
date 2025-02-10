import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/presentation/providers/raw_song_provider.dart';

enum FocusIndex {
  firstPrice,
  secondPrice,
  thirdPrice,
}

class RankingState {
  List<RawSongEntity> cardRanking;
  List<RawSongEntity> playlistRanking;
  DateTime updateTime;
  FocusIndex focusIndex;

  RankingState(
      this.cardRanking, this.playlistRanking, this.updateTime, this.focusIndex);

  RankingState copyWith({
    List<RawSongEntity>? cardRanking,
    List<RawSongEntity>? playlistRanking,
    DateTime? updateTime,
    FocusIndex? focusIndex,
  }) =>
      RankingState(
          cardRanking ?? this.cardRanking,
          playlistRanking ?? this.playlistRanking,
          updateTime ?? this.updateTime,
          focusIndex ?? FocusIndex.firstPrice);
}

class RankingViewModel extends AsyncNotifier<RankingState> {
  @override
  FutureOr<RankingState> build() async {
    try {
      List<RawSongEntity> cardRanking =
          await ref.read(rawSongUsecaseProvider).getCardRanking();
      List<RawSongEntity> playlistRanking =
          await ref.read(rawSongUsecaseProvider).getPlaylistRanking();

      return RankingState(cardRanking, playlistRanking, DateTime.now(), FocusIndex.firstPrice);
    } catch (e) {
      return RankingState([], [], DateTime.now(), FocusIndex.firstPrice);
    }
  }

  // 다시 읽기
  Future<void> fetchRanking() async {
    state = const AsyncValue.loading();

    try {
      List<RawSongEntity> cardRanking =
          await ref.read(rawSongUsecaseProvider).getCardRanking();
      List<RawSongEntity> playlistRanking =
          await ref.read(rawSongUsecaseProvider).getPlaylistRanking();

      state = AsyncValue.data(
          RankingState(cardRanking, playlistRanking, DateTime.now(), FocusIndex.firstPrice));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // 순위 클릭
  void changeFocusIndex(FocusIndex index){
    state = state.whenData((value)=>value.copyWith(focusIndex: index));
  }
}

final rankingViewModelProvider =
    AsyncNotifierProvider<RankingViewModel, RankingState>(() {
  return RankingViewModel();
});

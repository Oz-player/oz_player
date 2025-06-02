import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/spotify_entity.dart';
import 'package:oz_player/presentation/ui/search/search_provider.dart';

class SearchSpotifyViewModel extends Notifier<AsyncValue<List<SpotifyEntity>>> {
  @override
  AsyncValue<List<SpotifyEntity>> build() {
    return AsyncData([]); // 초기 상태는 빈 리스트
  }

  Future<void> fetchSpotify(String query) async {
    state = AsyncLoading(); // 로딩 상태로 변경
    try {
      final results = await ref.read(fetchSpotifyUsecaseProvider).execute(query);
      state = AsyncData(results!); // 성공적으로 데이터를 가져오면 상태 업데이트
    } catch (e, stack) {
      state = AsyncError(e, stack); // 에러 발생 시 에러 상태로 변경
    }
  }
}

// Provider 정의
final searchSpotifyListViewModel = NotifierProvider<SearchSpotifyViewModel, AsyncValue<List<SpotifyEntity>>>(
  () => SearchSpotifyViewModel(),
);

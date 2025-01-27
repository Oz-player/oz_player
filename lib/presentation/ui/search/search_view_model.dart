import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/spotify_entity.dart';
import 'package:oz_player/presentation/ui/search/search_provider.dart';

class SearchViewModel extends Notifier<List<SpotifyEntity>?>{
  @override
  List<SpotifyEntity>? build() {
    return [];
  }

  Future<void> fetchSearch(String query) async{
    state = await ref.read(fetchSpotifyUsecaseProvider).execute(query);
  }
  
}

final searchpageListViewModel = NotifierProvider<SearchViewModel, List<SpotifyEntity>?>(
  () => SearchViewModel(),
);
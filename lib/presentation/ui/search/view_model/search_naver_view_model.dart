import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/naver_entity.dart';
import 'package:oz_player/presentation/ui/search/search_provider.dart';

class SearchNaverViewModel extends Notifier<List<NaverEntity>?>{
  @override
  List<NaverEntity>? build() {
    return [];
  }

  Future<void> fetchNaver(String query) async{
    state = await ref.read(fetchNaverUsecaseProvider).naverExecute(query);
  }
  
}

final searchNaverViewModel = NotifierProvider<SearchNaverViewModel, List<NaverEntity>?>(
  () => SearchNaverViewModel(),
);
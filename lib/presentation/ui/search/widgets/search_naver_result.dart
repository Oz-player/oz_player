import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/search/view_model/search_naver_view_model.dart';

class SearchNaverResult extends ConsumerStatefulWidget {
  const SearchNaverResult({super.key});

  @override
  ConsumerState<SearchNaverResult> createState() => _SearchNaverResultState();
}

class _SearchNaverResultState extends ConsumerState<SearchNaverResult> {
  @override
  Widget build(BuildContext context) {
    final naverResults = ref.watch(searchNaverViewModel);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: naverResults!.length,
        itemBuilder: (context, index) {
          final result = naverResults[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.artist, // SpotifyEntity의 title 속성 사용
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          result.title,
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ), // SpotifyEntity의 artist 속성 사용
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}

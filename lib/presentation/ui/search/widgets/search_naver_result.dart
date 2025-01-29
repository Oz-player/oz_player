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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.artist, // SpotifyEntity의 title 속성 사용
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 20,
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
                SizedBox(
                  height: 40,
                  child: Text(
                    //성인 등급의 노래인 경우 naver에서 인증이 필요해서 로그인 문구가 뜨는것을 없앰
                    result.lyrics.contains('로그인 후 이용할 수 있는 컨텐츠입니다.')
                        ? '청소년 이용 불가 노래입니다'
                        : result.lyrics,
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

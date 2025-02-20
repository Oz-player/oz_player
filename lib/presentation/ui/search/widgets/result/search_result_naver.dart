import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart';
import 'package:oz_player/presentation/ui/search/view_model/search_naver_view_model.dart';
import 'package:oz_player/presentation/ui/search/widgets/bottomSheet/search_lyics_bottom_sheet.dart';

class SearchResultNaver extends ConsumerStatefulWidget {
  const SearchResultNaver({super.key});

  @override
  ConsumerState<SearchResultNaver> createState() => _SearchNaverResultState();
}

class _SearchNaverResultState extends ConsumerState<SearchResultNaver> {
  @override
  Widget build(BuildContext context) {
    final naverResults = ref.watch(searchNaverViewModel);


    //성인 등급의 노래인 경우 naver에서 인증이 필요해서 로그인 문구가 뜨는것을 없앰
    final filteredResults = naverResults!
        .where(
            (result) => !result.lyrics.contains('로그인<\/a> 후 이용할 수 있는 컨텐츠입니다.'))
        .toList();

    if (filteredResults.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/search_result.png'),
            alignment: Alignment(0, -0.5),
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        final result = filteredResults[index];
        return GestureDetector(
          onTap: () {
            context.push('/search/lyrics', extra: {
              'song': result.title,
              'artist': result.artist,
              'lyrics': result.lyrics,
            });
          },
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24,0,0,0),
                  child: Column(
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  result.title, // SpotifyEntity의 title 속성 사용
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                result.artist,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                    overflow: TextOverflow.ellipsis,
                                    ),
                                
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: Text(
                          parse(result.lyrics).body!.text,
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SearchLyicsBottomSheet(
                        song: result.title,
                        artist: result.artist,
                        lyrics: result.lyrics,
                      );
                    },
                  );
                },
                icon: Image.asset(
                  'assets/images/menu_thin_icon.png',
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Color(0xFFE5E8EB),
        );
      },
    );
  }
}

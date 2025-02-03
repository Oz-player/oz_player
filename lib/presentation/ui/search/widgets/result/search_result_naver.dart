import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final screenWidth = MediaQuery.of(context).size.width; // 화면의 가로 크기


    if(naverResults!.isEmpty){
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/search_result.png'),
              alignment: Alignment(0, -0.5)
            )
          )
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: naverResults.length,
        itemBuilder: (context, index) {
          final result = naverResults[index];
          return Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            result.title, // SpotifyEntity의 title 속성 사용
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          result.artist,
                          style: TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ), // SpotifyEntity의 artist 속성 사용
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth-80,
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
              IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                      return SearchLyicsBottomSheet(
                        song: result.title,
                        artist: result.artist,
                    );
                  },
                );
              },
              icon: Image.asset(
                'assets/images/menu_thin_icon.png',
              ),
            ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/search/widgets/search_naver_result.dart';
import 'package:oz_player/presentation/ui/search/widgets/search_spotify_result.dart';

class SearchResultPage extends ConsumerStatefulWidget {
  const SearchResultPage({super.key});

  @override
  ConsumerState<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends ConsumerState<SearchResultPage> {
  bool titleButton = true;
  bool lyricsButton = false;

  void changeSelected(bool isTitle) {
    setState(() {
      if (isTitle) {
        titleButton = true;
        lyricsButton = false; // 가사 검색 버튼 해제
      } else {
        titleButton = false; // 제목 검색 버튼 해제
        lyricsButton = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              
              fit: BoxFit.fitWidth),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      if (!titleButton) {
                        changeSelected(true);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          titleButton ? Color(0xff40017E) : Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Color(0xffE5E8EB))),
                      ),
                    ),
                    child: Text(
                      '제목 검색',
                      style: TextStyle(
                        color: titleButton ? Colors.white : Colors.grey[600],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      if (!lyricsButton) {
                        changeSelected(false);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        lyricsButton ? Color(0xff40017E) : Colors.white,
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xffE5E8EB)),
                        ),
                      ),
                    ),
                    child: Text(
                      '가사 검색',
                      style: TextStyle(
                        color: lyricsButton ? Colors.white : Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: titleButton ? SearchSpotifyResult() : SearchNaverResult(),
            ),
          ],
        ),
      ),
    );
  }
}


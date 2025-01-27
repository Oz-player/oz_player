import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/search/search_view_model.dart';

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
 final searchResults = ref.watch(searchpageListViewModel);

if (searchResults == null) {
  return const Center(child: CircularProgressIndicator());
}

if (searchResults.isEmpty) {
  return const Center(child: Text('검색 결과가 없습니다.'));
}

    return SafeArea(
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
                        titleButton ? Colors.grey : Colors.white),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: Text('제목 검색'),
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
                        lyricsButton ? Colors.grey : Colors.white),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: Text('가사 검색'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: searchResults?.length ?? 0,
              itemBuilder: (context, index) {
                final result = searchResults![index]; // SpotifyEntity
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                              result.name, // SpotifyEntity의 title 속성 사용
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(result.type, style: TextStyle(fontSize: 16)), // SpotifyEntity의 artist 속성 사용
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
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
// import 'package:oz_player/presentation/ui/search/widgets/result/search_result_naver.dart';
import 'package:oz_player/presentation/ui/search/widgets/result/search_result_spotify.dart';

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
                        titleButton ? AppColors.main800 : Colors.white),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xffE5E8EB))),
                    ),
                  ),
                  child: Text(
                    '제목 검색',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: titleButton ? Colors.white : Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // TextButton(
                //   onPressed: () {
                //     if (!lyricsButton) {
                //       changeSelected(false);
                //     }
                //   },
                //   style: ButtonStyle(
                //     backgroundColor: WidgetStateProperty.all(
                //       lyricsButton ? AppColors.main800 : Colors.white,
                //     ),
                //     shape: WidgetStateProperty.all(
                //       RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8),
                //         side: BorderSide(color: Color(0xffE5E8EB)),
                //       ),
                //     ),
                //   ),
                //   child: Text(
                //     '가사 검색',
                //     style: TextStyle(
                //       fontWeight: FontWeight.w500,
                //       fontSize: 16,
                //       color: lyricsButton ? Colors.white : Colors.grey[600],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: SearchResultSpotify(),
          ),
        ],
      ),
    );
  }
}

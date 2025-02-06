import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/search/view_model/search_naver_view_model.dart';
import 'package:oz_player/presentation/ui/search/view_model/search_spotify_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchArea extends ConsumerStatefulWidget {
  final Function(String) onSearch;
  final VoidCallback onCancel;

  const SearchArea({super.key, required this.onSearch, required this.onCancel});

  @override
  ConsumerState<SearchArea> createState() => _SearchAreaState();
}

class _SearchAreaState extends ConsumerState<SearchArea> {
  final TextEditingController _textEditingController = TextEditingController();

  Future<void> saveSearchText(String text) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? searchHistory = prefs.getStringList('searchHistory') ?? [];
    if (!searchHistory.contains(text)) {
      searchHistory.add(text);
      await prefs.setStringList('searchHistory', searchHistory);
    }
  }

  void clearText() {
    _textEditingController.clear();
    widget.onSearch('');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: SizedBox(
            height: 45,
            child: TextFormField(
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                fontSize: 16
              ),
              controller: _textEditingController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                hintText: '제목 또는 가사 검색',
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12)),
                suffixIcon: _textEditingController.text.isNotEmpty
                    ? IconButton(
                        icon: Image.asset('assets/images/icon_delete.png'),
                        onPressed: clearText, // 검색어 지우기
                      )
                    : null,
              ),
              onFieldSubmitted: (text) {
                if (text.isNotEmpty) {
                  widget.onSearch(text);
                  saveSearchText(text);
                  ref.read(searchSpotifyListViewModel.notifier).fetchSpotify(text);
                  ref.read(searchNaverViewModel.notifier).fetchNaver(text);
                  print('onsearch 호출됨');
                } else {
                  // 검색어가 비어있을 때 clearText 호출
                  widget.onSearch('');
                }
              },
            ),
          ),
        ),
        TextButton(
          onPressed: () {
    _textEditingController.clear(); // 텍스트 필드 비우기
    widget.onCancel(); // 검색 모드 해제 호출
    print('취소 호출됨');
          },
          child: Text(
            '취소',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}

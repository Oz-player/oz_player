import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/search/widgets/search_area.dart';
import 'package:oz_player/presentation/ui/search/widgets/search_result_page.dart';
import 'package:oz_player/presentation/ui/search/widgets/search_word_page.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? searchText; // 검색어를 저장할 변수

  void _updateSearchText(String text) {
    setState(() {
      searchText = text; // 검색어 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchArea(onSearch: _updateSearchText), // 검색 콜백 전달
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              // 검색어가 없으면 기본 화면, 있으면 검색 결과 화면
              searchText == null
                  ? SearchWordPage() // 기본 화면
                  : SearchResultPage()
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/search/widgets/search_area.dart';
import 'package:oz_player/presentation/ui/search/widgets/search_page.dart';
import 'package:oz_player/presentation/ui/search/widgets/result/search_result_page.dart';
import 'package:oz_player/presentation/ui/search/widgets/search_word_page.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';
import 'package:oz_player/presentation/widgets/loading/loading_view_model/loading_view_model.dart';
import 'package:oz_player/presentation/widgets/loading/loading_widget.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  String? searchText; // 검색어를 저장할 변수
  bool isSearching = false;

  void _updateSearchText(String text) {
    setState(() {
      searchText = text; // 검색어 업데이트
      isSearching = true; // 검색어가 비어있지 않으면 검색 모드
    });
  }

  void _resetSearch() {
    setState(() {
      searchText = null; // 검색어 초기화
      isSearching = false; // 검색 모드 해제
    });
  }

  @override
  Widget build(BuildContext context) {
    final loadingState = ref.watch(loadingViewModelProvider);

    return loadingState.isLoading
        ? Stack(
            children: [
              Scaffold(
                  resizeToAvoidBottomInset: false, // 배경화면의 이미지가 키보드에 영향을 받지 않음
                  appBar: AppBar(
                    title: SearchArea(
                      onSearch: _updateSearchText,
                      onCancel: _resetSearch, // 취소 콜백 추가
                    ),
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
                          isSearching
                              ? searchText!.isEmpty
                                  ? SearchWordPage() // 기본 화면
                                  : SearchResultPage()
                              : SearchPage(),
                          Positioned(
                            bottom: 23,
                            left: 0,
                            right: 0,
                            child: AudioPlayer(colorMode: true), // 색상 모드에 맞게 설정
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: HomeBottomNavigation()),
              LoadingWidget(),
            ],
          )
        : Scaffold(
            resizeToAvoidBottomInset: false, // 배경화면의 이미지가 키보드에 영향을 받지 않음
            appBar: AppBar(
              title: SearchArea(
                onSearch: _updateSearchText,
                onCancel: _resetSearch, // 취소 콜백 추가
              ),
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0,
            ),
            body: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Stack(
                  children: [
                    // 검색어가 없으면 기본 화면, 있으면 검색 결과 화면
                    isSearching
                        ? searchText!.isEmpty
                            ? SearchWordPage() // 기본 화면
                            : SearchResultPage()
                        : SearchPage(),
                    Positioned(
                      bottom: 23,
                      left: 0,
                      right: 0,
                      child: AudioPlayer(colorMode: true), // 색상 모드에 맞게 설정
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: HomeBottomNavigation());
  }
}

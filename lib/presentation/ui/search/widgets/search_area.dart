import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/search/view_model/search_naver_view_model.dart';
import 'package:oz_player/presentation/ui/search/view_model/search_spotify_view_model.dart';

class SearchArea extends ConsumerStatefulWidget {
  final Function(String) onSearch; // 검색 콜백 함수

  const SearchArea({super.key, required this.onSearch});

  @override
  ConsumerState<SearchArea> createState() => _SearchAreaState();
}

class _SearchAreaState extends ConsumerState<SearchArea> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 300,
          height: 38,
          child: Flexible(
            child: TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                hintText: '제목 또는 가사 검색',
                hintStyle: TextStyle(
                  fontSize: 16,
                  
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(100)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
          ),
        ),
        SizedBox(width: 20,),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            final text = _textEditingController.text;
            if (text.isNotEmpty) {
              widget.onSearch(text); 
              ref.read(searchSpotifyListViewModel.notifier).fetchSpotify(text);
              ref.read(searchNaverViewModel.notifier).fetchNaver(text);
              print('onsearch 호출됨');
            }
            
          },
        ),
      ],
    );
  }
}

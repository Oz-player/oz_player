import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/search/search_view_model.dart';

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
      children: [
        Expanded(
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black12,
              hintText: '검색어를 입력하세요',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(100)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(100)),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            final text = _textEditingController.text;
            if (text.isNotEmpty) {
              widget.onSearch(text); 
              ref.read(searchpageListViewModel.notifier).fetchSearch(text);
              print('onsearch 호출됨');
            }
            
          },
        ),
      ],
    );
  }
}

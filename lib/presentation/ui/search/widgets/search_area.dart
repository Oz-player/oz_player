import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchArea extends StatelessWidget {
  SearchArea({
    super.key,
  });

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
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
              context.go('/search/searchResult');
            },
          ),
        ],
      ),
    );
  }
}

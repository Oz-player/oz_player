import 'package:flutter/material.dart';

class SearchArea extends StatelessWidget {
  SearchArea({
    super.key,
  });

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: '검색어를 입력해주세요',
          border: UnderlineInputBorder(),
          suffixIcon: Icon(Icons.search)
        ),
      ),
    );
  }
}
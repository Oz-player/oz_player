import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/search/widgets/search_word_page.dart';

class SearchBody extends StatelessWidget{
  SearchBody({super.key});

  final Widget bodyPage = SearchWordPage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        bodyPage,
        
      ],
    );
  }
}
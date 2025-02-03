import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget{
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/search_page.png'),
              alignment: Alignment(0, -0.5)
            )
          )
    );
  }

}
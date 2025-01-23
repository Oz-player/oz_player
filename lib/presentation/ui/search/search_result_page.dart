import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/search/widgets/search_area.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchArea(),
      )
      ,
      body: SafeArea(
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}

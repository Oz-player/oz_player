import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/search/widgets/search_area.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            SearchArea(),
            Expanded(
              child: ListView(
                
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchArea(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Text(
                        '최근 검색어',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.search),
                          Text(
                            '태연',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),Row(
                        children: [
                          Icon(Icons.search),
                          Text(
                            '태연',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),Row(
                        children: [
                          Icon(Icons.search),
                          Text(
                            '태연',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

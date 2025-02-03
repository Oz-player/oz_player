import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchWordPage extends StatefulWidget {
  const SearchWordPage({super.key});

  @override
  State<SearchWordPage> createState() => _SearchWordPageState();
}

class _SearchWordPageState extends State<SearchWordPage> {
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
    print(searchHistory.length);
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      searchHistory =
          prefs.getStringList('searchHistory') ?? []; // 검색어 리스트 불러오기
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '최근 검색어',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: searchHistory.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.search, size: 24),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          searchHistory[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

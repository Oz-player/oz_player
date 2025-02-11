import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchWordPage extends StatefulWidget {
  const SearchWordPage({super.key});

  @override
  State<SearchWordPage> createState() => _SearchWordPageState();
}

class _SearchWordPageState extends State<SearchWordPage> {
  List<String> searchHistory = [];
  bool deleteMode = false;

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
    log('${searchHistory.length}');
    deleteMode = false;
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      searchHistory =
          prefs.getStringList('searchHistory') ?? []; // 검색어 리스트 불러오기
    });
  }

  Future<void> _deleteSearchHistory(String searchTerm) async {
    final prefs = await SharedPreferences.getInstance();
    searchHistory.remove(searchTerm);
    await prefs.setStringList('searchHistory', searchHistory);
    setState(() {});
  }

  void _toggleDeleteMode() {
    setState(() {
      deleteMode = !deleteMode; // 삭제 모드 토글
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              TextButton(
                onPressed: () {
                  _toggleDeleteMode();
                  log('deleteMode : $deleteMode');
                },
                child: Text(deleteMode ? '취소' : '기록 삭제'),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount:
                    searchHistory.length < 10 ? searchHistory.length : 10,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 24, color: Colors.grey[400],),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              searchHistory[searchHistory.length - 1 - index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                          child: deleteMode
                              ? IconButton(
                                  padding: EdgeInsets.zero, // 패딩 설정
                                  constraints: BoxConstraints(), // constraints
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.grey[600],
                                  ),
                                  iconSize: 20,
                                  onPressed: () {
                                    _deleteSearchHistory(searchHistory[searchHistory.length - 1 - index]);
                                  },
                                )
                              : Text(''),
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

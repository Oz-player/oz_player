import 'package:flutter/material.dart';

class SearchWordPage extends StatelessWidget {
  const SearchWordPage({super.key});

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
                itemCount: 5,
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
                          '태연$index',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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

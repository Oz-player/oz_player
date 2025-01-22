import 'package:flutter_test/flutter_test.dart';
import 'package:oz_player/data/source/naver/naver_search_data_source_impl.dart'; // Update with the correct import path

void main() {
  test('naver api test', () async {
    // Initialize the data source
    NaverSearchDataSourceImpl naverSearchDataSourceImpl = NaverSearchDataSourceImpl();
    
    // Fetch the search results
    final searchResults = await naverSearchDataSourceImpl.fetchNaver('내일은 너무 멀어 지금');
    
    // Validate that the result is not empty
    expect(searchResults.isEmpty, false);

    // Print each result
    for (final result in searchResults) {
      print('Title: ${result.title}');
      print('Artist: ${result.artist}');
      print('Lyrics: ${result.lyrics}');
      print('Link: ${result.link}');
      print('-------------------');
    }
  });
}

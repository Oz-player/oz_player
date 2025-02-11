import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:oz_player/data/source/naver/naver_search_data_source_impl.dart'; // Update with the correct import path

void main() {
  test('naver api test', () async {
    // Initialize the data source
    NaverSearchDataSourceImpl naverSearchDataSourceImpl = NaverSearchDataSourceImpl();
    
    // Fetch the search results
    final searchResults = await naverSearchDataSourceImpl.fetchNaver("Switch my whip, came back in black");
    
    // Validate that the result is not empty
    expect(searchResults.isEmpty, false);

    for (final result in searchResults) {
      log('Title: ${result.title}');
      log('Artist: ${result.artist}');
      log('Lyrics: ${result.lyrics}');
      log('Link: ${result.link}');
      log('-------------------');
    }
  });
}

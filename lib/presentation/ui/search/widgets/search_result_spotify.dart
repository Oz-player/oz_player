import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/search/view_model/search_spotify_view_model.dart';

class SearchResultSpotify extends ConsumerStatefulWidget {
  const SearchResultSpotify({super.key});

  @override
  ConsumerState<SearchResultSpotify> createState() =>
      _SearchSpotifyResultState();
}

class _SearchSpotifyResultState extends ConsumerState<SearchResultSpotify> {
  @override
  Widget build(BuildContext context) {
    final spotifyResults = ref.watch(searchSpotifyListViewModel);

    final tracks = spotifyResults!.where((result) => result.type == 'track').toList();
    final atrist = spotifyResults.where((result) => result.type == 'artist').toList(); 

    return ListView.separated(
      itemCount: spotifyResults.length,
      itemBuilder: (context, index) {
        final result = spotifyResults[index]; // SpotifyEntity
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3.43),
                child: Image.network(
                  result.type == 'track'
                      ? result.album!['images'].first['url']
                      : result.images?.first['url'],
                  width: 56,
                  height: 56,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 20,
                      child: Text(
                        result.name, // SpotifyEntity의 title 속성 사용
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      result.type == 'track'
                      ? result.album!['artists'].first['name']
                      : result.genres.toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ), // SpotifyEntity의 artist 속성 사용
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}

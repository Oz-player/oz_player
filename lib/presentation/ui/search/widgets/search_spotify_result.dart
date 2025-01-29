import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/search/view_model/search_spotify_view_model.dart';

class SearchSpotifyResult extends ConsumerStatefulWidget {
  const SearchSpotifyResult({super.key});

  @override
  ConsumerState<SearchSpotifyResult> createState() =>
      _SearchSpotifyResultState();
}

class _SearchSpotifyResultState extends ConsumerState<SearchSpotifyResult> {
  @override
  Widget build(BuildContext context) {
    final spotifyResults = ref.watch(searchSpotifyListViewModel);

    return ListView.separated(
      itemCount: spotifyResults!.length,
      itemBuilder: (context, index) {
        final result = spotifyResults[index]; // SpotifyEntity
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.name, // SpotifyEntity의 title 속성 사용
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(result.type,
                        style: TextStyle(
                            fontSize: 16)), // SpotifyEntity의 artist 속성 사용
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

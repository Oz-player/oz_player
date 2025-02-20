import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oz_player/presentation/ui/search/view_model/search_spotify_view_model.dart';
import 'package:oz_player/presentation/ui/search/widgets/bottomSheet/search_song_bottom_sheet.dart';

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

    // final tracks =
    //     spotifyResults!.where((result) => result.type == 'track').toList();
    // final artists =
    //     spotifyResults.where((result) => result.type == 'artist').toList();

    if (spotifyResults!.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/search_result.png'),
            alignment: Alignment(0, -0.5),
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: spotifyResults.length + 1,
      itemBuilder: (context, index) {
        if (index == spotifyResults.length) {
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SvgPicture.asset('assets/svg/list_trailer.svg', height: 40,),
            ),
          );
        } else {
          final result = spotifyResults[index]; // SpotifyEntity

          final imageUrl = result.type == 'track' &&
                  result.album != null &&
                  result.album!['images'].isNotEmpty
              ? result.album!['images'].first['url']
              : result.images?.isNotEmpty == true
                  ? result.images!.first['url']
                  : '';
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3.43),
                  child: Image.network(
                    imageUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/char/oz_3.png',
                        width: 56,
                        height: 56,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Text(
                            result.name, // SpotifyEntity의 title 속성 사용
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          result.type == 'track'
                              ? result.album!['artists'].first['name']
                              : result.genres!.isNotEmpty
                                  ? result.genres.toString()
                                  : '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ), // SpotifyEntity의 artist 속성 사용
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SearchSongBottomSheet(
                          imgUrl: imageUrl,
                          artist: result.type == 'track'
                              ? result.album!['artists'].first['name']
                              : result.genres!.isNotEmpty
                                  ? result.genres.toString()
                                  : '',
                          title: result.name,
                        );
                      },
                    );
                  },
                  icon: Semantics(
                    label: '음악 옵션',
                    child: Image.asset(
                      'assets/images/menu_thin_icon.png',
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Color(0xFFE5E8EB),
        );
      },
    );
  }
}

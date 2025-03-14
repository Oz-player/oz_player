import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oz_player/presentation/ui/search/view_model/search_spotify_view_model.dart';
import 'package:oz_player/presentation/ui/search/widgets/bottomSheet/search_song_bottom_sheet.dart';

class SearchResultSpotify extends ConsumerStatefulWidget {
  const SearchResultSpotify({super.key});

  @override
  ConsumerState<SearchResultSpotify> createState() => _SearchSpotifyResultState();
}

class _SearchSpotifyResultState extends ConsumerState<SearchResultSpotify> {
  @override
  Widget build(BuildContext context) {
    final spotifyResults = ref.watch(searchSpotifyListViewModel);

    return spotifyResults.when(
      data: (results) {
        if (results.isEmpty) {
          return Center(
            child: Text('검색 결과가 없습니다.'),
          );
        }

        return ListView.separated(
          itemCount: results.length + 1,
          itemBuilder: (context, index) {
            if (index == results.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SvgPicture.asset('assets/svg/list_trailer.svg', height: 40),
              );
            } else {
              final result = results[index];
              final imageUrl = _getImageUrl(result);

              List<dynamic> artistNames = result.artists!.map((artist) => artist['name']).toList();
              String artistNamesString = artistNames.join(', ');

              return _buildListItem(
                imageUrl: imageUrl,
                title: result.name,
                artistNames: artistNamesString,
                onPressed: () {
                  _showBottomSheet(context, imageUrl, artistNamesString, result.name);
                },
              );
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Color(0xFFE5E8EB));
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()), // 로딩 인디케이터
      error: (error, stack) => Center(child: Text('오류 발생: ${error.toString()}')), // 에러 메시지
    );
  }

  String _getImageUrl(result) {
    return result.type == 'track' && result.album != null && result.album!['images'].isNotEmpty
        ? result.album!['images'].first['url']
        : result.images?.isNotEmpty == true
            ? result.images!.first['url']
            : '';
  }

  Widget _buildListItem({
    required String imageUrl,
    required String title,
    required String artistNames,
    required VoidCallback onPressed,
  }) {
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
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    artistNames,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Semantics(
              label: '음악 옵션',
              child: Image.asset('assets/images/menu_thin_icon.png'),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String imageUrl, String artist, String title) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return SearchSongBottomSheet(
          imgUrl: imageUrl,
          artist: artist,
          title: title,
        );
      },
    );
  }
}

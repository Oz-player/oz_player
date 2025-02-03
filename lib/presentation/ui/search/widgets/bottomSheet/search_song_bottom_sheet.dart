import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/search/widgets/bottomSheet/bottom_sheet_button.dart';

class SearchSongBottomSheet extends StatelessWidget {
  const SearchSongBottomSheet(
      {super.key, required this.imgUrl, required this.artist});

  final String imgUrl;
  final String artist;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
      child: Container(
        height: 248,
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3.43),
                      child: Image.network(
                        imgUrl,
                        width: 56,
                        height: 56,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      child: Text(
                        artist,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25),
                bottomSheetButton(context, '재생', () {
                }),
                SizedBox(height: 10),
                bottomSheetButton(context, '플레이리스트에 저장', () {
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

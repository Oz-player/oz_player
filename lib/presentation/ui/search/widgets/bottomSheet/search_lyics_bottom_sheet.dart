import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/search/widgets/bottomSheet/bottom_sheet_button.dart';

class SearchLyicsBottomSheet extends StatelessWidget {
  const SearchLyicsBottomSheet({
    super.key,
    required this.song,
    required this.artist,
  });

  final String song;
  final String artist;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
      child: Container(
        height: 300,
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      child: Text(
                        song,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      height: 50,
                    ),
                    SizedBox(
                      child: Text(
                        artist,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25),
                bottomSheetButton(context, '가사 보기', () {
                }),
                SizedBox(height: 10),
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

import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class LyricsBottom extends StatelessWidget {
  const LyricsBottom({
    super.key,
    required this.song,
    required this.artist,
    required this.lyrics,
  });

  final String song;
  final String artist;
  final String lyrics;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  child: Text(
                    song,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard-SemiBold'
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
                      fontSize: 14,
                      fontFamily: 'Pretendard-Medium'
                    ),
                  ),
                )
              ],
            ),
            Text(
              parse(lyrics).body!.innerHtml.replaceAll('<br>', '\n'), //가사에 <br>로 줄 바꿈
              style: TextStyle(fontSize: 14, fontFamily: 'Pretendard-Medium'),
            )
          ],
        ),
      ),
    );
  }
}

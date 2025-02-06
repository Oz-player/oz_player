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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
      ),
      height: 800,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: Text(
                      song,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Pretendard',
                      ),
                      overflow: TextOverflow.ellipsis,
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
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            Text(
              parse(lyrics)
                  .body!
                  .innerHtml
                  .replaceAll('<br>', '\n'), //가사에 <br>로 줄 바꿈
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[900]),
            ),
          ],
        ),
      ),
    );
  }
}

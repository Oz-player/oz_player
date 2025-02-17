import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';

class LyricsPage extends StatelessWidget {
  const LyricsPage({
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
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: ExcludeSemantics(
          child: Text('가사 검색'),
        ),
        leading: Semantics(
          button: true,
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back,
              semanticLabel: '검색으로 돌아가기',
            ),
            color: Colors.grey[900],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: Semantics(
                      label: '제목',
                      child: Text(
                        song,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                  height: 50,
                ),
                SizedBox(
                  child: Semantics(
                    label: '가수',
                    child: Text(
                      artist,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
            Semantics(
              label: '가사 읽기를 시작합니다. 두 번 탭해 정지하세요.',
              child: Text(
                parse(lyrics)
                    .body!
                    .innerHtml
                    .replaceAll('<br>', '\n'), //가사에 <br>로 줄 바꿈
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

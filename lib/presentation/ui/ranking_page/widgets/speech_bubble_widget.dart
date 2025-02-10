import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_bottomsheet.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';
import 'package:oz_player/presentation/widgets/speech_ballon/speech_ballon.dart';

class SpeechBubbleWidget extends ConsumerWidget {
  const SpeechBubbleWidget({super.key, this.nipLocation, this.song});

  final RawSongEntity? song;
  final NipLocation? nipLocation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (song == null) {
      return SpeechBalloon(
          nipLocation: nipLocation ?? NipLocation.bottom,
          borderRadius: 8,
          nipHeight: 20,
          color: Colors.black.withValues(alpha: 0.32),
          width: 230,
          height: 120,
          child: Center(
              child: Text(
            '랭킹 확인 중입니다',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          )));
    }
    return SpeechBalloon(
        nipLocation: nipLocation ?? NipLocation.bottom,
        borderRadius: 8,
        nipHeight: 20,
        color: Colors.black.withValues(alpha: 0.32),
        width: 256,
        height: 120,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                ),
                SizedBox(
                    width: 60, height: 60, child: Image.network(song!.imgUrl)),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 130,
                      child: AutoSizeText(
                        song!.title,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 14,
                        maxLines: 1,
                        wrapWords: false,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: AutoSizeText(
                        song!.artist,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 12,
                        maxLines: 1,
                        wrapWords: false,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ],
        ));
  }
}

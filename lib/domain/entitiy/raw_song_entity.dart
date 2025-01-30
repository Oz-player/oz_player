import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';

// SongEntity와 달리 분위기, 상황 태그 등을 제외하고
// Firebase에 기록된 Song 정보만 가져온 엔티티입니다

class RawSongEntity {
  VideoInfoEntitiy video;
  String songId;
  String title;
  String imgUrl;
  String artist;

  RawSongEntity({
    required this.video,
    required this.songId,
    required this.title,
    required this.imgUrl,
    required this.artist,
  });
}

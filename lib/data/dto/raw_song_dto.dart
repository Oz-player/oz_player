import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';

class RawSongDto {
  VideoInfoEntitiy video;
  String title;
  String imgUrl;
  String artist;

  RawSongDto({
    required this.video,
    required this.title,
    required this.imgUrl,
    required this.artist,
  });

  factory RawSongDto.fromJson(Map<String, dynamic> json) {
    return RawSongDto(
      video: VideoInfoEntitiy.fromJson(json['videoInfo']),
      title: json['title'],
      imgUrl: json['imgUrl'],
      artist: json['artist'],
    );
  }
}

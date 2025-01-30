import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';

class FirebaseSongDTO {
  VideoInfoEntitiy video;
  String title;
  String imgUrl;
  String artist;

  FirebaseSongDTO({
    required this.video,
    required this.title,
    required this.imgUrl,
    required this.artist,
  });

  factory FirebaseSongDTO.fromJson(Map<String, dynamic> json) {
    return FirebaseSongDTO(
      video: json['videoInfo'],
      title: json['title'],
      imgUrl: json['imgUrl'],
      artist: json['artist'],
    );
  }
}

import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';

class SongEntitiy {
  VideoInfoEntitiy video;
  String title;
  String imgUrl;
  String artist;

  SongEntitiy(
      {required this.video,
      required this.title,
      required this.imgUrl,
      required this.artist});
}

import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';

class SongEntitiy {
  VideoInfoEntitiy video;
  String title;
  String imgUrl;
  String artist;
  List<String> moodlist;
  String situation;
  String genre;
  String favoriteArtist;
  String? memo;

  SongEntitiy({
    required this.video,
    required this.title,
    required this.imgUrl,
    required this.artist,
    required this.moodlist,
    required this.situation,
    required this.genre,
    required this.favoriteArtist,
    this.memo,
  });
}

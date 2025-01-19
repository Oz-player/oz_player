import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';

abstract class VideoInfoRepository {
  Future<VideoInfoEntitiy> getVideoInfo(String songName, String artist);
}
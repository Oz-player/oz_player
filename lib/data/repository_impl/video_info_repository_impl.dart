import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';
import 'package:oz_player/domain/repository/video_info_repository.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoInfoRepositoryImpl implements VideoInfoRepository {
  @override
  Future<VideoInfoEntitiy> getVideoInfo(String songName, String artist) async {
    final yt = YoutubeExplode();
    final video = await yt.search.search('$artist $songName');

    return VideoInfoEntitiy.yt(video);
  }
}

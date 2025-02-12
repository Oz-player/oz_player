import 'dart:developer';

import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';
import 'package:oz_player/domain/repository/video_info_repository.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoInfoRepositoryImpl implements VideoInfoRepository {
  @override
  Future<VideoInfoEntitiy> getVideoInfo(String songName, String artist) async {
    try {
      log('$songName 비디오 정보 불러오기 시작');
      final yt = YoutubeExplode();
      final video = await yt.search.search('$artist $songName');
      log('비디오 정보 불러오기 성공');

      final manifest =
          await yt.videos.streamsClient.getManifest(video.first.id.value);

      log('오디오 정보 추출 성공');
      return VideoInfoEntitiy.yt(video, manifest);
    } catch (e) {
      log('비디오 또는 오디오 로딩 실패');
      return VideoInfoEntitiy.empty();
    }
  }
}

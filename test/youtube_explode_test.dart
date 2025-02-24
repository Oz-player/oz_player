import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oz_player/data/repository_impl/video_info_repository_impl.dart';
import 'package:oz_player/domain/usecase/video_info_usecase.dart';

void main() async{
  test('YOUTUBE EXPLODE TEST _ Search', () async {
    final videoInfoRepository = VideoInfoRepositoryImpl();
    final videoInfoUsecase = VideoInfoUsecase(videoInfoRepository);

    final songName = '신호등';
    final artist = '이무진';
    final video = await videoInfoUsecase.getVideoInfo(songName, artist);
    final videoId = video.id;
    final videoTitle = video.title;
    final videoDuration = video.duration;
    final videoUrl = video.url;
    final audioUrl = video.audioUrl;

    debugPrint('title : $videoTitle, \nid : $videoId, \nduration : $videoDuration, \nUrl : $videoUrl, \naudioUrl : $audioUrl');

    expect(video.id != '', true);
  });
}
import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';
import 'package:oz_player/domain/repository/video_info_repository.dart';

class VideoInfoUsecase {
  VideoInfoUsecase(this._videoInfoRepository);
  final VideoInfoRepository _videoInfoRepository;

  /// songName 하고 artist 를 매개변수로써
  /// youtube의 검색결과중 가장 최상단에 있는 영상 정보를 출력
  /// id, title, duration, url
  Future<VideoInfoEntitiy> getVideoInfo(String songName, String artist) async {
    final result = await _videoInfoRepository.getVideoInfo(songName, artist);
    return result;
  }
}
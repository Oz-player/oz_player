import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/data/repository_impl/video_info_repository_impl.dart';
import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';

abstract class VideoInfoRepository {
  Future<VideoInfoEntitiy> getVideoInfo(String songName, String artist);
}

final videoInfoRepositoryProvider = Provider<VideoInfoRepository>((ref){
  return VideoInfoRepositoryImpl();
});
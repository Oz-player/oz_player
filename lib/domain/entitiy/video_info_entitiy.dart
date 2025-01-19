import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoInfoEntitiy {
  final String id;
  final String title;
  final Duration? duration;
  final String url;

  VideoInfoEntitiy({required this.id, required this.title, required this.duration, required this.url});

  VideoInfoEntitiy.yt(VideoSearchList video) : this (
    id: video.first.id.value,
    title: video.first.title,
    duration: video.first.duration,
    url: video.first.url
  );
}
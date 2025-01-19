import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoInfoEntitiy {
  final String id;
  final String title;
  final Duration? duration;
  final String url;
  final String audioUrl;

  VideoInfoEntitiy({required this.id, required this.title, required this.duration, required this.url, required this.audioUrl});

  VideoInfoEntitiy.yt(VideoSearchList video, StreamManifest manifest) : this (
    id: video.first.id.value,
    title: video.first.title,
    duration: video.first.duration,
    url: video.first.url,
    audioUrl: manifest.audioOnly.first.url.toString(),
  );
}
import 'package:oz_player/data/util/duration_parse.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoInfoEntitiy {
  final String id;
  final String title;
  final Duration? duration;
  final String url;
  final String audioUrl;

  VideoInfoEntitiy(
      {required this.id,
      required this.title,
      required this.duration,
      required this.url,
      required this.audioUrl});

  VideoInfoEntitiy.yt(VideoSearchList video, StreamManifest manifest)
      : this(
          id: video.first.id.value,
          title: video.first.title,
          duration: video.first.duration,
          url: video.first.url,
          audioUrl: manifest.audioOnly.first.url.toString(),
        );

  // firebase에서 Song entity를 가져올 때 활용
  VideoInfoEntitiy.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          duration: durationParse(json['duration']),
          url: json['url'],
          audioUrl: json['audioUrl'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration.toString(),
      'url': url,
      'audioUrl': audioUrl,
    };
  }

  VideoInfoEntitiy.empty()
      : this(
          id: '',
          title: '',
          duration: null,
          url: '',
          audioUrl: '',
        );
}

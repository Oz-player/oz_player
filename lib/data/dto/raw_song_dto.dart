import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';

// 1. RawSongEntity 생성
// 2. SongEntity에 값 전달 => LibraryEntity 값과 합쳐 SongEntity 생성

class RawSongDto {
  VideoInfoEntitiy video;
  String songId;
  String title;
  String imgUrl;
  String artist;

  RawSongDto({
    required this.video,
    required this.songId,
    required this.title,
    required this.imgUrl,
    required this.artist,
  });

  factory RawSongDto.fromJson(Map<String, dynamic> json, String docId) {
    return RawSongDto(
      video: VideoInfoEntitiy.fromJson(json['videoInfo']),
      songId: docId,
      title: json['title'],
      imgUrl: json['imgUrl'],
      artist: json['artist'],
    );
  }

  RawSongEntity toEntity() {
    return RawSongEntity(
      video: video,
      songId: songId,
      title: title,
      imgUrl: imgUrl,
      artist: artist,
    );
  }

  RawSongDto.fromEntity(RawSongEntity entity)
      : this(
          video: entity.video,
          songId: entity.songId,
          title: entity.title,
          imgUrl: entity.imgUrl,
          artist: entity.artist,
        );

  Map<String, dynamic> toJson() {
    return {
      'video': video.toJson(),
      'songId': songId,
      'title': title,
      'imgUrl': imgUrl,
      'artist': artist,
    };
  }
}

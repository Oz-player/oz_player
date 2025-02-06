import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';

// 1. RawSongEntity 생성
// 2. SongEntity에 값 전달 => LibraryEntity 값과 합쳐 SongEntity 생성

class RawSongDto {
  int countLibrary;
  int countPlaylist;
  VideoInfoEntitiy video;
  String title;
  String imgUrl;
  String artist;

  RawSongDto({
    required this.countLibrary,
    required this.countPlaylist,
    required this.video,
    required this.title,
    required this.imgUrl,
    required this.artist,
  });

  factory RawSongDto.fromJson(Map<String, dynamic> json) {
    return RawSongDto(
      countLibrary: json['countLibrary'] as int,
      countPlaylist: json['countPlaylist'] as int,
      video: VideoInfoEntitiy.fromJson(json['video']),
      title: json['title'],
      imgUrl: json['imgUrl'],
      artist: json['artist'],
    );
  }

  RawSongEntity toEntity() {
    return RawSongEntity(
      countLibrary: countLibrary,
      countPlaylist: countPlaylist,
      video: video,
      title: title,
      imgUrl: imgUrl,
      artist: artist,
    );
  }

  RawSongDto.fromEntity(RawSongEntity entity)
      : this(
          countLibrary: entity.countLibrary,
          countPlaylist: entity.countPlaylist,
          video: entity.video,
          title: entity.title,
          imgUrl: entity.imgUrl,
          artist: entity.artist,
        );

  Map<String, dynamic> toJson() {
    return {
      'countLibrary': countLibrary,
      'countPlaylist': countPlaylist,
      'video': video.toJson(),
      'title': title,
      'imgUrl': imgUrl,
      'artist': artist,
    };
  }
}

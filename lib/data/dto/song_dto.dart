import 'package:oz_player/data/dto/raw_song_dto.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/song_entitiy.dart';
import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';

// firebase의 song entity와 library collection의 정보를 합침
class SongDTO {
  late VideoInfoEntitiy video;
  late String title;
  late String imgUrl;
  late String artist;
  late String mood;
  late String situation;
  late String genre;
  late String favoriteArtist;
  String? memo;

  SongDTO({
    required RawSongDto rawSongDto,
    required LibraryEntity libraryEntity,
  }) {
    artist = rawSongDto.artist;
    imgUrl = rawSongDto.imgUrl;
    title = rawSongDto.title;
    video = rawSongDto.video;
    mood = libraryEntity.mood;
    situation = libraryEntity.situation;
    genre = libraryEntity.genre;
    favoriteArtist = libraryEntity.favoriteArtist;
    memo = libraryEntity.memo;
  }

  SongEntitiy toEntity() {
    return SongEntitiy(
      video: video,
      title: title,
      imgUrl: imgUrl,
      artist: artist,
      mood: mood,
      situation: situation,
      genre: genre,
      favoriteArtist: favoriteArtist,
      memo: memo,
    );
  }
}

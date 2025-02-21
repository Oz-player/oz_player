import 'package:oz_player/domain/entitiy/library_entity.dart';

class LibraryDto {
  final DateTime createdAt;
  final String artist;
  final String imgUrl;
  final String title;
  final String favoriteArtist;
  final String genre;
  final String? memo;
  final String mood;
  final String situation;
  final String songId;

  LibraryDto({
    required this.createdAt,
    required this.artist,
    required this.imgUrl,
    required this.title,
    required this.favoriteArtist,
    required this.genre,
    required this.memo,
    required this.mood,
    required this.situation,
    required this.songId,
  });

  factory LibraryDto.fromJson(Map<String, dynamic> json) {
    return LibraryDto(
      createdAt: DateTime.parse(json['createdAt'] as String),
      artist: json['artist'],
      imgUrl: json['imgUrl'],
      title: json['title'],
      favoriteArtist: json['favoriteArtist'],
      genre: json['genre'],
      memo: json['memo'],
      mood: json['mood'],
      situation: json['situation'],
      songId: json['songId'],
    );
  }

  LibraryEntity toEntity() {
    return LibraryEntity(
      createdAt: createdAt,
      artist: artist,
      imgUrl: imgUrl,
      title: title,
      favoriteArtist: favoriteArtist,
      genre: genre,
      memo: memo,
      mood: mood,
      situation: situation,
      songId: songId,
    );
  }

  LibraryDto.fromEntity(LibraryEntity entity)
      : this(
            createdAt: entity.createdAt,
            artist: entity.artist,
            imgUrl: entity.imgUrl,
            title: entity.title,
            favoriteArtist: entity.favoriteArtist,
            genre: entity.genre,
            memo: entity.memo,
            mood: entity.mood,
            situation: entity.situation,
            songId: entity.songId);

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'artist': artist,
      'imgUrl': imgUrl,
      'title': title,
      'favoriteArtist': favoriteArtist,
      'genre': genre,
      'memo': memo,
      'mood': mood,
      'situation': situation,
      'songId': songId,
    };
  }
}

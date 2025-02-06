import 'package:oz_player/data/dto/recommend_music_dto.dart';

class RecommendMusicEntity {
  final String? musicName;
  final String? artist;

  RecommendMusicEntity({required this.musicName, required this.artist});

  RecommendMusicEntity.fromJson(Map<String, dynamic> json) : this (
    musicName: json['musicName'].split(' - ')[1],
    artist: json['musicName'].split(' - ')[0],
  );

  RecommendMusicEntity.fromRecommendMusicDto(RecommendMusicDto dto) : this(
    musicName: dto.musicName!.split(' - ')[1],
    artist: dto.musicName!.split(' - ')[0],
  );

  RecommendMusicEntity.empty() : this (
    musicName: null,
    artist: null,
  );
}
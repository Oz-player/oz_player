class RecommendMusicDto {
  final String? musicName;
  final String? artist;

  RecommendMusicDto({required this.musicName, required this.artist});

  RecommendMusicDto.fromJson(Map<String, dynamic> json) : this (
    musicName: json['musicName'],
    artist: json['artist'],
  );

  RecommendMusicDto.empty() : this (
    musicName: null,
    artist: null,
  );
}
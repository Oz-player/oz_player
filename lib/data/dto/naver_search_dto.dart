class NaverSearchDto {
  final String title;
  final String artist;
  final String lyrics;
  final String link;

  NaverSearchDto({
    required this.title,
    required this.artist,
    required this.lyrics,
    required this.link,
  });

  // JSON 데이터로부터 DTO 생성
  NaverSearchDto.fromJson(Map<String, dynamic> json)
      : this(
          title: json['title'] as String,
          artist: json['artist'] as String,
          lyrics: json['lyrics'] as String,
          link: json['link'] as String,
        );
}

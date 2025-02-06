class ManiadbSongDto {
  final String id;
  final String title;
  final String runningTime;
  final String link;
  final String pubDate;
  final String author;
  final String description;
  final String comments;
  final Map<String, dynamic> album;  // 앨범 정보를 Map으로 수정
  final Map<String, dynamic> artist;  // 아티스트 정보를 Map으로 수정

  ManiadbSongDto({
    required this.id,
    required this.title,
    required this.runningTime,
    required this.link,
    required this.pubDate,
    required this.author,
    required this.description,
    required this.comments,
    required this.album,
    required this.artist,
  });

  ManiadbSongDto.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] ?? '',
          title: json['title'] ?? '',
          runningTime: json['runningTime'] ?? '',
          link: json['link'] ?? '',
          pubDate: json['pubDate'] ?? '',
          author: json['author'] ?? '',
          description: json['description'] ?? 'description 없음',
          comments: json['comments'] ?? '',
          album: json['maniadb:album'] != null ? {
            'title': json['maniadb:album']['title'] ?? '',
            'release': json['maniadb:album']['release'] ?? '',
            'link': json['maniadb:album']['link'] ?? '',
          } : {},
          artist: json['maniadb:artist'] != null ? {
            'name': json['maniadb:artist']['name'] ?? '',
            'link': json['maniadb:artist']['link'] ?? '',
          } : {},
        );
}

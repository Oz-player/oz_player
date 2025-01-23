class ManiadbSongDto {
  final String id;
  final String title;
  final String runningTime;
  final String link;
  final String pubDate;
  final String author;
  final String description;
  final String comments;
  final List<dynamic> album;
  final List<dynamic> artist;

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
          description: json['description'] ?? '',
          comments: json['comments'] ?? '',
          album: json['album'] ?? [],
          artist: json['artist'] ?? [],
        );
}

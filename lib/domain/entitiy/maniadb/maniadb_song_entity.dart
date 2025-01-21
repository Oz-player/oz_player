class ManiadbSongEntity {
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

  ManiadbSongEntity({
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

}
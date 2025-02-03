class LibraryEntity {
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

  LibraryEntity({
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
}

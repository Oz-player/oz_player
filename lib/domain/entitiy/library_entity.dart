class LibraryEntity {
  final DateTime createdAt;
  final String favoriteArtist;
  final String genre;
  final String memo;
  final String mood;
  final String situation;
  final String songId;

  LibraryEntity({
    required this.createdAt,
    required this.favoriteArtist,
    required this.genre,
    required this.memo,
    required this.mood,
    required this.situation,
    required this.songId,
  });
}

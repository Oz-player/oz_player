class ManiadbArtistEntity {
  String id;
  String title;
  String reference;
  String demographic;
  String period;
  String link;
  String image;
  String linkGallery;
  String linkDiscography;
  String pubDate;
  String author;
  String description;
  String guid;
  String comments;
  List<dynamic> majorSongs;
  String majorSongList;

  ManiadbArtistEntity({
    required this.id,
    required this.title,
    required this.reference,
    required this.demographic,
    required this.period,
    required this.link,
    required this.image,
    required this.linkGallery,
    required this.linkDiscography,
    required this.pubDate,
    required this.author,
    required this.description,
    required this.guid,
    required this.comments,
    required this.majorSongs,
    required this.majorSongList,
  });
}
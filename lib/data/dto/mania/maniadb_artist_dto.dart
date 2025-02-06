class ManiadbArtistDto {
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
  Map<String, dynamic> majorSongs;
  String majorSongList;

  ManiadbArtistDto({
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

  ManiadbArtistDto.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] ?? '',
          title: json['title'] ?? '',
          reference: json['reference'] ?? '',
          demographic: json['demographic'] ?? '',
          period: json['period'] ?? '',
          link: json['link'] ?? '',
          image: json['image'] ?? '',
          linkGallery: json['maniadb:linkgallery'] ?? '',
          linkDiscography: json['maniadb:linkdiscography'] ?? '',
          pubDate: json['pubDate'] ?? '',
          author: json['author'] ?? '',
          description: json['description'] ?? '',
          guid: json['guid'] ?? '',
          comments: json['comments'] ?? '',
          majorSongs: json['maniadb:majorsongs'] !=null ? {
            'id':json['maniadb:majorsongs']['id'] ?? '',
            'name':json['maniadb:majorsongs']['name'] ?? '',
            'merchants':json['maniadb:majorsongs']['merchants'] ?? '',
          }: {},
          majorSongList: json['maniadb:majorsonglist'] ?? '',
        );
}

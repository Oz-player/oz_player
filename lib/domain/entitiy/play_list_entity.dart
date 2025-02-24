class PlayListEntity {
  String listName;
  String? imgUrl;
  String description;
  DateTime createdAt;
  List<String> songIds;

  PlayListEntity({
    required this.listName,
    required this.createdAt,
    required this.imgUrl,
    required this.description,
    required this.songIds,
  });
}

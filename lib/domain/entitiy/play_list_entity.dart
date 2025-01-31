class PlayListEntity {
  String listName;
  String imgUrl;
  String description;
  List<String> songIds;

  PlayListEntity({
    required this.listName,
    required this.imgUrl,
    required this.description,
    required this.songIds,
  });
}

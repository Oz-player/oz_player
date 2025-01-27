class PlayListEntity {
  String listName;
  String imgUrl;
  List<String> songIds;

  PlayListEntity({
    required this.listName,
    required this.imgUrl,
    required this.songIds,
  });
}

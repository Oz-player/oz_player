import 'package:oz_player/domain/entitiy/play_list_entity.dart';

class PlayListDTO {
  final String listName;
  final String imgUrl;
  final String description;
  final List<String> songIds;

  PlayListDTO({
    required this.listName,
    required this.imgUrl,
    required this.description,
    required this.songIds,
  });

  factory PlayListDTO.fromJson(Map<String, dynamic> json) {
    return PlayListDTO(
      listName: json['listName'],
      imgUrl: json['imgUrl'],
      description: json['description'],
      songIds:
          (json['songIds'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

  PlayListEntity toEntity() {
    return PlayListEntity(
      listName: listName,
      imgUrl: imgUrl,
      description: description,
      songIds: songIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listName': listName,
      'imgUrl': imgUrl,
      'description': description,
      'songIds': songIds,
    };
  }
}

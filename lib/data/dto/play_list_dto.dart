import 'package:oz_player/domain/entitiy/play_list_entity.dart';

class PlayListDTO {
  final String listName;
  final String? imgUrl;
  final String description;
  final DateTime createdAt;
  final List<String> songIds;

  PlayListDTO({
    required this.listName,
    required this.imgUrl,
    required this.description,
    required this.createdAt,
    required this.songIds,
  });

  factory PlayListDTO.fromJson(Map<String, dynamic> json) {
    return PlayListDTO(
      listName: json['listName'],
      imgUrl: json['imgUrl'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt'] as String),
      songIds:
          (json['songIds'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

  PlayListEntity toEntity() {
    return PlayListEntity(
      listName: listName,
      imgUrl: imgUrl,
      description: description,
      createdAt: createdAt,
      songIds: songIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listName': listName,
      'imgUrl': imgUrl,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'songIds': songIds,
    };
  }
}

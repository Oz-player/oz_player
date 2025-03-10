class SpotifyEntity {
  final String id; // ID
  final String name; // 이름
  final String type; // 타입 (artist, track)
  final String uri; // URI
  final int popularity; // 인기 점수
  final List<dynamic>? genres; // 장르 (아티스트에 대해서만)
  final Map<String, dynamic>? followers; // 팔로워 정보 (아티스트에 대해서만)
  final List<Map<String, dynamic>>? images; // 이미지 정보 (아티스트에 대해서만)
  final int? durationMs; // 트랙 길이 (밀리초, 트랙에 대해서만)
  final bool? explicit; // 명시적 여부 (트랙에 대해서만)
  final String? previewUrl; // 미리 듣기 URL (트랙에 대해서만)
  final Map<String, dynamic>? album; // 앨범 정보 (트랙에 대해서만)
  final List<dynamic>? artists;

  SpotifyEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.uri,
    required this.popularity,
    required this.genres,
    required this.followers,
    required this.images,
    required this.durationMs,
    required this.explicit,
    required this.previewUrl,
    required this.album,
    required this.artists,
  });
}

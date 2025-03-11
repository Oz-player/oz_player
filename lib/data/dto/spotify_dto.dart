class SpotifyDto {
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

  SpotifyDto({
    required this.id,
    required this.name,
    required this.type,
    required this.uri,
    this.popularity = 0,
    this.genres,
    this.followers,
    this.images,
    this.durationMs,
    this.explicit,
    this.previewUrl,
    this.album,
    this.artists,

  });

  factory SpotifyDto.fromJson(Map<String, dynamic> json) {
    // 아티스트 정보인지 트랙 정보인지 확인
    if (json['type'] == 'artist') {
      return SpotifyDto(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        type: json['type'] ?? '',
        uri: json['uri'] ?? '',
        popularity: json['popularity'] ?? 0,
        genres: json['genres'] ?? [],
        followers: json['followers'] ?? {},
        images: List<Map<String, dynamic>>.from(json['images'] ?? []),
      );
    } else if (json['type'] == 'track') {
      return SpotifyDto(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        type: json['type'] ?? '',
        uri: json['uri'] ?? '',
        popularity: json['popularity'] ?? 0,
        durationMs: json['duration_ms'] ?? 0,
        explicit: json['explicit'] ?? false,
        previewUrl: json['preview_url'] ?? '',
        album: json['album'] ?? {},
        artists: json['artists'] ?? {},
      );
    }
    throw Exception('Unknown type: ${json['type']}');
  }
}

import 'dart:developer';
import 'package:oz_player/data/dto/raw_song_dto.dart';
import 'package:oz_player/data/source/firebase_songs/raw_song_source.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';
import 'package:oz_player/domain/repository/saved/raw_song_repository.dart';

class RawSongRepositoryImpl implements RawSongRepository {
  final RawSongSource _source;

  RawSongRepositoryImpl(this._source);

  @override
  Future<RawSongEntity?> getRawSong(String songId) async {
    final dto = await _source.getRawSong(songId);
    if (dto == null) return null;
    return dto.toEntity();
  }

  @override
  Future<List<RawSongEntity>> getRawSongs(List<String> songIds) async {
    final list = await _source.getRawSongs(songIds);
    return list.map((song) => song.toEntity()).toList();
  }

  @override
  Future<void> updateRawSongByLibrary(RawSongDto dto) async {
    await _source.updateRawSongByLibrary(dto);
  }

  @override
  Future<void> updateRawSongByPlaylist(RawSongDto dto) async {
    await _source.updateRawSongByPlaylist(dto);
  }

  @override
  Future<void> updateVideo(RawSongDto dto) async {
    await _source.updateVideo(dto);
  }

  @override
  Future<List<RawSongDto>> getCardRanking() async {
    final sourceList = await _source.getCardRanking();
    final dummy = RawSongDto(
      countLibrary: 0,
      countPlaylist: 0,
      video: VideoInfoEntitiy.empty(),
      title: '데이터가 없습니다.',
      imgUrl:
          'https://github.com/user-attachments/assets/b12b1ec8-3646-4b66-bd87-e7470f3d833e',
      artist: '데이터가 없습니다',
    );

    List<RawSongDto> resultList = sourceList.reversed.toList();
    resultList.sort((a, b) => a.countLibrary.compareTo(b.countLibrary));
    // 곡이 3개 미만인 경우 더미 데이터로 나머지를 채움
    while (resultList.length < 3) {
      resultList.add(dummy);
    }
    for (var item in resultList) {
      log('title: ${item.title}, count: ${item.countLibrary}');
    }
    return resultList;
  }

  @override
  Future<List<RawSongDto>> getPlaylistRanking() async {
    final sourceList = await _source.getPlaylistRanking();
    final dummy = RawSongDto(
      countLibrary: 0,
      countPlaylist: 0,
      video: VideoInfoEntitiy.empty(),
      title: '데이터가 없습니다.',
      imgUrl:
          'https://github.com/user-attachments/assets/b12b1ec8-3646-4b66-bd87-e7470f3d833e',
      artist: '데이터가 없습니다',
    );

    List<RawSongDto> resultList = sourceList.reversed.toList();
    resultList.sort((a, b) => b.countPlaylist.compareTo(a.countPlaylist));
    // 곡이 3개 미만인 경우 더미 데이터로 나머지를 채움
    while (resultList.length < 3) {
      resultList.add(dummy);
    }
    for (var item in resultList) {
      log('title: ${item.title}, count: ${item.countLibrary}');
    }
    return resultList;
  }
}

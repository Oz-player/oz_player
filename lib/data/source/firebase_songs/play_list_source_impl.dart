import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oz_player/data/dto/play_list_dto.dart';
import 'package:oz_player/data/dto/raw_song_dto.dart';
import 'package:oz_player/data/source/firebase_songs/play_list_source.dart';

class PlayListSourceImpl implements PlayListSource {
  final FirebaseFirestore _firestore;

  PlayListSourceImpl(this._firestore);

  // 유저의 전체 플레이리스트를 가져옴
  @override
  Future<List<PlayListDTO>> getPlayLists(String userId) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();

      if (doc.exists && doc.data() != null) {
        log('$userId의 플레이리스트 목록을 찾았습니다!');

        final data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('playlists') && data['playlists'] is List) {
          return (data['playlists'] as List)
              .map((value) => PlayListDTO.fromJson(value))
              .toList();
        } else {
          return [];
        }
      }

      log('$userId의 플레이리스트 목록이 없습니다');
      return [];
    } catch (e, stackTrace) {
      log('playlist error: $e, stackTrace: $stackTrace');
      return [];
    }
  }

  // 유저의 전체 플레이리스트 중 이름이 일치하는 특정 플레이리스트를 가져옴
  @override
  Future<PlayListDTO?> getPlayList(String userId, String listName) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('playlists') && data['playlists'] is List) {
          final list = (data['playlists'] as List)
              .map((e) => PlayListDTO.fromJson(e))
              .toList();

          return list.firstWhere(
            (item) => item.listName == listName,
          );
        }
      }
      return null;
    } catch (e, stackTrace) {
      log('error: $e, stackTrace: $stackTrace');
      return null;
    }
  }

  // 문서에 새로운 플레이리스트 추가
  @override
  Future<bool> addPlayList(String userId, PlayListDTO dto) async {
    try {
      // 1. 유저의 플레이리스트 문서가 존재하는지 확인
      final doc = await _firestore.collection('Playlist').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;
        // 2. 유저의 플레이리스트 안에 동일한 제목이 존재하는지 확인
        if (data.containsKey('playlists') && data['playlists'] is List) {
          for (var item in data['playlists']) {
            if (item['listName'] == dto.listName) {
              log('이미 존재하는 제목의 플레이리스트입니다.');
              return false;
            }
          }
          await _firestore.collection('Playlist').doc(userId).update({
            'playlists': FieldValue.arrayUnion([dto.toJson()])
          });
          log('${dto.listName}을 플레이리스트에 저장했습니다');
          return true;
        }
      }
      // 3. 유저의 플레이리스트 문서가 존재하지 않는다면 생성
      final docRef = _firestore.collection('Playlist').doc(userId);
      await docRef.set({
        'playlists': [dto.toJson()]
      });
      return true;
    } catch (e, stackTrace) {
      log('error: $e, stackTrace: $stackTrace');
      return false;
    }
  }

  // 이미 존재하는 플레이리스트 필드의 songIds 배열에 추가
  @override
  Future<void> addSong(String userId, String listName, RawSongDto dto) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();
      final playlistRef = _firestore.collection('Playlist').doc(userId);

      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('playlists') && data['playlists'] is List) {
          List<dynamic> playlist = data['playlists'];

          for (var item in playlist) {
            if (item['listName'] == listName) {
              await playlistRef.update({
                'playlists': FieldValue.arrayRemove([item]),
              });

              item['songIds'] = (item['songIds'] as List?) ?? [];
              item['songIds'].add(dto.video.id);
              if (item['imgUrl'] == null) {
                item['imgUrl'] = dto.imgUrl;
              }

              await playlistRef.update({
                'playlists': FieldValue.arrayUnion([item])
              });
              break;
            }
          }
        }
      }
    } catch (e, stackTrace) {
      log('error: $e, stackTrace: $stackTrace');
    }
  }

  // 플레이리스트 삭제
  @override
  Future<void> deletePlayList(String userId, String listName) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();
      final deleteRef = _firestore.collection('Playlist').doc(userId);

      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('playlists') && data['playlists'] is List) {
          List<dynamic> playlist = data['playlists'];

          for (var item in playlist) {
            if (item['listName'] == listName) {
              log('$listName 을 찾았습니다');
              await deleteRef.update({
                'playlists': FieldValue.arrayRemove([item]),
              });
              log('$listName 을 삭제했습니다');

              break;
            }
          }
        }
      }
    } catch (e, stackTrace) {
      log('error: $e, stackTrace: $stackTrace');
    }
  }

  // 플레이리스트에서 특정 곡 삭제
  @override
  Future<void> deleteSong(String userId, String listName, String songId) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();
      final deleteRef = _firestore.collection('Playlist').doc(userId);

      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('playlists') && data['playlists'] is List) {
          List<dynamic> playlist = data['playlists'];

          for (var item in playlist) {
            if (item['listName'] == listName) {
              await deleteRef.update({
                'playlists': FieldValue.arrayRemove([item]),
              });

              item['songIds'] = (item['songIds'] as List?) ?? [];
              item['songIds'].remove(songId);

              await deleteRef.update({
                'playlists': FieldValue.arrayUnion([item])
              });

              break;
            }
          }
        }
      }
    } catch (e, stackTrace) {
      log('error: $e, stackTrace: $stackTrace');
    }
  }

  // 플레이리스트 제목 수정
  @override
  Future<void> editListName(
      String userId, String listName, String newName) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();
      final editRef = _firestore.collection('Playlist').doc(userId);

      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('playlists') && data['playlists'] is List) {
          List<dynamic> playlist = data['playlists'];

          for (var item in playlist) {
            if (item['listName'] == listName) {
              await editRef.update({
                'playlists': FieldValue.arrayRemove([item]),
              });

              item['listName'] = newName;

              await editRef.update({
                'playlists': FieldValue.arrayUnion([item])
              });
              log('$newName으로 업데이트에 성공했습니다');
              break;
            }
          }
        }
      }
    } catch (e, stackTrace) {
      log('error: $e, stackTrace: $stackTrace');
    }
  }

  // 플레이리스트 설명 수정
  @override
  Future<void> editDescription(
      String userId, String listName, String newDescription) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();
      final editRef = _firestore.collection('Playlist').doc(userId);

      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('playlists') && data['playlists'] is List) {
          List<dynamic> playlist = data['playlists'];

          for (var item in playlist) {
            if (item['listName'] == listName) {
              await editRef.update({
                'playlists': FieldValue.arrayRemove([item]),
              });

              item['description'] = newDescription;

              await editRef.update({
                'playlists': FieldValue.arrayUnion([item])
              });
              log('$newDescription 으로 업데이트에 성공했습니다');
              break;
            }
          }
        }
      }
    } catch (e, stackTrace) {
      log('error: $e, stackTrace: $stackTrace');
    }
  }

  // 플레이리스트 곡 순서 재설정
  @override
  Future<void> editSongOrder(
      String userId, String listName, List<String> songIds) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();
      final playlistRef = _firestore.collection('Playlist').doc(userId);

      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('playlists') && data['playlists'] is List) {
          List<dynamic> playlist = data['playlists'];
          for (var item in playlist) {
            if (item['listName'] == listName) {
              await playlistRef.update({
                'playlists': FieldValue.arrayRemove([item]),
              });

              item['songIds'] = songIds;

              await playlistRef.update({
                'playlists': FieldValue.arrayUnion([item])
              });
              log('곡 순서를 새로고침했습니다');
              break;
            }
          }
        }
      }
    } catch (e, stackTrace) {
      log('error: $e, stackTrace: $stackTrace');
    }
  }

  @override
  Future<void> clearPlaylist(String userId) async {
    try {
      await _firestore.collection('Playlist').doc(userId).delete();
      log('$userId의 플레이리스트를 삭제하였습니다.');
    } catch (e, stackTrace) {
      log('e: $e, stackTrace: $stackTrace');
    }
  }
}

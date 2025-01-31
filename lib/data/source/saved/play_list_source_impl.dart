import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oz_player/data/dto/play_list_dto.dart';
import 'package:oz_player/data/source/saved/play_list_source.dart';

class PlayListSourceImpl implements PlayListSource {
  final FirebaseFirestore _firestore;

  PlayListSourceImpl(this._firestore);

  // NOTICE : (add 관련) 플레이리스트에 음악을 넣을 때
  // firebase-Song 콜렉션에도 추가해야 합니다
  // Song 콜렉션이 명확하게 정해지고 나서 기능 추가 예정

  // 유저의 전체 플레이리스트를 가져옴
  @override
  Future<List<PlayListDTO>> getPlayLists(String userId) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();
      if (doc.exists) {
        print('$userId의 플레이리스트 목록을 찾았습니다!');
        return (doc.data() as List)
            .map((value) => PlayListDTO.fromJson(value))
            .toList();
      }
      print('$userId의 플레이리스트 목록이 없습니다');
      return [];
    } catch (e, stackTrace) {
      print('playlist error: $e, stackTrace: $stackTrace');
      return [];
    }
  }

  // 유저의 전체 플레이리스트 중 이름이 일치하는 특정 플레이리스트를 가져옴
  @override
  Future<PlayListDTO?> getPlayList(String userId, String listName) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();
      if (doc.exists) {
        final list =
            (doc.data() as List).map((e) => PlayListDTO.fromJson(e)).toList();
        for (var item in list) {
          if (item.listName == listName) {
            return item;
          }
        }
      }
      return null;
    } catch (e, stackTrace) {
      print('error: $e, stackTrace: $stackTrace');
      return null;
    }
  }

  // 문서에 새로운 플레이리스트 추가
  @override
  Future<void> addPlayList(String userId, PlayListDTO playListDTO) async {
    try {
      await _firestore.collection('Playlist').doc(userId).set({
        'playlist': FieldValue.arrayUnion([
          playListDTO.toJson(),
        ])
      });
    } catch (e, stackTrace) {
      print('error: $e, stackTrace: $stackTrace');
    }
  }

  // 이미 존재하는 플레이리스트 필드의 songIds 배열에 추가
  @override
  Future<void> addSong(String userId, String listName, String songId) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();
      final addSongRef = _firestore.collection('Playlist').doc(userId);

      if (doc.exists) {
        List playlist = doc.data() as List;
        // title이 일치하는 플레이리스트 탐색
        for (var item in playlist) {
          if (item['title'] == listName) {
            // 기존 item 삭제 후 재업로드
            await addSongRef.update({
              'playlist': FieldValue.arrayRemove([item]),
            });
            item['songIds'] = FieldValue.arrayUnion([songId]);
            await addSongRef.update({
              'playlist': FieldValue.arrayUnion([item])
            });
            break;
          }
        }
      }
    } catch (e, stackTrace) {
      print('error: $e, stackTrace: $stackTrace');
    }
  }

  // 플레이리스트 삭제
  @override
  Future<void> deletePlayList(String userId, String listName) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();
      final deleteRef = _firestore.collection('Playlist').doc(userId);

      if (doc.exists) {
        List playlist = doc.data() as List;
        // title이 일치하는 플레이리스트 탐색
        for (var item in playlist) {
          if (item['title'] == listName) {
            await deleteRef.update({
              'playlist': FieldValue.arrayRemove([item]),
            });
            break;
          }
        }
      }
    } catch (e, stackTrace) {
      print('error: $e, stackTrace: $stackTrace');
    }
  }

  // 플레이리스트에서 특정 곡 삭제
  @override
  Future<void> deleteSong(String userId, String listName, String songId) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();
      final deleteRef = _firestore.collection('Playlist').doc(userId);

      if (doc.exists) {
        List playlist = doc.data() as List;
        // title이 일치하는 플레이리스트 탐색
        for (var item in playlist) {
          if (item['title'] == listName) {
            // 기존 item 삭제 후 재업로드
            await deleteRef.update({
              'playlist': FieldValue.arrayRemove([item]),
            });
            item['songIds'] = FieldValue.arrayRemove([songId]);
            await deleteRef.update({
              'playlist': FieldValue.arrayUnion([item])
            });
            break;
          }
        }
      }
    } catch (e, stackTrace) {
      print('error: $e, stackTrace: $stackTrace');
    }
  }
}

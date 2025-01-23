import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oz_player/data/dto/play_list_dto.dart';
import 'package:oz_player/data/source/play_list/play_list_source.dart';

class PlayListSourceImpl implements PlayListSource {
  final FirebaseFirestore _firestore;

  PlayListSourceImpl(this._firestore);

  // 유저의 전체 플레이리스트를 가져옴
  @override
  Future<List<PlayListDTO>> getPlayLists(String userId) async {
    try {
      final doc = await _firestore.collection('Playlist').doc(userId).get();
      return (doc.data() as List).map((e) => PlayListDTO.fromJson(e)).toList();
    } catch (e, stackTrace) {
      print('error: $e, stackTrace: $stackTrace');
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

  // 문서에 새로운 플레이리스트 필드 추가
  @override
  Future<void> addPlayList(String userId, PlayListDTO playListDTO) async {
    try {
      await _firestore.collection('Playlist').doc(userId).set({
        playListDTO.listName: [
          playListDTO.toJson(),
        ]
      }, SetOptions(merge: true));
    } catch (e, stackTrace) {
      print('error: $e, stackTrace: $stackTrace');
    }
  }

  // 이미 존재하는 플레이리스트 필드의 songIds 배열에 추가
  @override
  Future<void> addSong(String userId, String listName, String songId) async {
    try {
      await _firestore.collection('Playlist').doc(userId).update({
        '$listName.songIds': FieldValue.arrayUnion([songId])
      });
    } catch (e, stackTrace) {
      print('error: $e, stackTrace: $stackTrace');
    }
  }

  // 플레이리스트 삭제
  @override
  Future<void> deletePlayList(String userId, String listName) async {
    try {
      await _firestore
          .collection('Playlist')
          .doc(userId)
          .update({listName: FieldValue.delete()});
    } catch (e, stackTrace) {
      print('error: $e, stackTrace: $stackTrace');
    }
  }

  // 플레이리스트에서 특정 곡 삭제
  @override
  Future<void> deleteSong(String userId, String listName, String songId) async {
    try {
      await _firestore.collection('Playlist').doc(userId).update({
        '$listName.songIds': FieldValue.arrayRemove([songId])
      });
    } catch (e, stackTrace) {
      print('error: $e, stackTrace: $stackTrace');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oz_player/data/dto/library_dto.dart';
import 'package:oz_player/data/source/firebase_songs/library_source.dart';

class LibrarySourceImpl implements LibrarySource {
  final FirebaseFirestore _firestore;

  LibrarySourceImpl(this._firestore);

  @override
  Future<List<LibraryDto>> getLibrary(String userId) async {
    try {
      final doc = await _firestore.collection('Library').doc(userId).get();

      if (doc.exists && doc.data() != null) {
        print('$userId의 라이브러리 목록을 찾았습니다!');

        final data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('songs') && data['songs'] is List) {
          return (data['songs'] as List)
              .map((value) => LibraryDto.fromJson(value))
              .toList();
        }
      }
      return [];
    } catch (e, stackTrace) {
      print('e: $e, stack: $stackTrace');
      return [];
    }
  }

  @override
  Future<void> createLibrary(LibraryDto dto, String userId) async {
    try {
      // 1. 유저의 라이브러리 문서가 존재하는지 확인
      final doc = await _firestore.collection('Library').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;
        // 2. 유저의 라이브러리 안에 동일한 곡이 존재하는지 확인
        if (data.containsKey('songs') && data['songs'] is List) {
          for (var item in data['songs']) {
            if (item['songId'] == dto.songId) {
              print('이미 라이브러리에 존재하는 곡입니다.');
              return;
            }
          }
          await _firestore.collection('Library').doc(userId).update({
            'songs': FieldValue.arrayUnion([dto.toJson()])
          });
          print('${dto.songId}을 라이브러리에 저장했습니다');
          return;
        }
      }
      // 3. 유저의 라이브러리 문서가 존재하지 않는다면 생성
      final docRef = _firestore.collection('Library').doc(userId);
      await docRef.set({
        'songs': [dto.toJson()]
      });
      return;
    } catch (e, stackTrace) {
      print('e: $e, stack: $stackTrace');
    }
  }

  @override
  Future<void> deleteLibrary(String songId, String userId) async {
    try {
      final doc = await _firestore.collection('Library').doc(userId).get();
      final deleteRef = _firestore.collection('Library').doc(userId);

      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('songs') && data['songs'] is List) {
          List<dynamic> library = data['songs'];

          for (var item in library) {
            if (item['songId'] == songId) {
              await deleteRef.update({
                'songs': FieldValue.arrayRemove([item])
              });
              break;
            }
          }
        }
      }
    } catch (e, stackTrace) {
      print('e: $e, stack: $stackTrace');
    }
  }
}

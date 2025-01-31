import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oz_player/data/dto/library_dto.dart';
import 'package:oz_player/data/source/saved/library_source.dart';

class LibrarySourceImpl implements LibrarySource {
  final FirebaseFirestore _firestore;

  LibrarySourceImpl(this._firestore);

  @override
  Future<List<LibraryDto>> getLibrary(String userId) async {
    try {
      final doc = await _firestore.collection('Library').doc(userId).get();
      if (doc.exists) {
        print('$userId의 라이브러리 목록을 찾았습니다!');
        List data = doc.data() as List;
        return data.map((value) => LibraryDto.fromJson(value)).toList();
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
      await _firestore.collection('Library').doc(userId).update({
        'library': FieldValue.arrayUnion([dto.toJson()])
      });
    } catch (e, stackTrace) {
      print('e: $e, stack: $stackTrace');
    }
  }

  @override
  Future<void> deleteLibrary(String songId, String userId) async {
    try {
      final doc = await _firestore.collection('Library').doc(userId).get();
      final deleteRef = _firestore.collection('Library').doc(userId);
      if (doc.exists) {
        List library = doc.data() as List;
        for (var item in library) {
          if (item['songId'] == songId) {
            await deleteRef.update({
              'library': FieldValue.arrayRemove([item])
            });
            break;
          }
        }
      }
    } catch (e, stackTrace) {
      print('e: $e, stack: $stackTrace');
    }
  }
}

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
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data.values.map((value) => LibraryDto.fromJson(value)).toList();
      }
      return [];
    } catch (e, stackTrace) {
      print('e: $e, stack: $stackTrace');
      return [];
    }
  }
}

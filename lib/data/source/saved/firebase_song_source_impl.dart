import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oz_player/data/dto/firebase_song_dto.dart';
import 'package:oz_player/data/source/saved/firebase_song_source.dart';

class FirebaseSongSourceImpl implements FirebaseSongSource {
  final FirebaseFirestore _firestore;

  FirebaseSongSourceImpl(this._firestore);

  // Firebase/Song에서 객체를 가져오는 함수입니다
  // Entity 없이 DTO를 바로 SongRepository에 전달합니다
  @override
  Future<FirebaseSongDTO?> getFirebaseSong(String songId) async {
    try {
      final doc = await _firestore.collection('Song').doc(songId).get();
      if (doc.exists && doc.data() != null) {
        return FirebaseSongDTO.fromJson(doc.data()!);
      }
      return null;
    } catch (e, stackTrace) {
      print('e: $e, stack: $stackTrace');
      return null;
    }
  }
}

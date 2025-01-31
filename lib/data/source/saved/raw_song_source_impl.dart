import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oz_player/data/dto/raw_song_dto.dart';
import 'package:oz_player/data/source/saved/raw_song_source.dart';

class RawSongSourceImpl implements RawSongSource {
  final FirebaseFirestore _firestore;

  RawSongSourceImpl(this._firestore);

  // Firebase/Song collection에서 객체를 가져오는 함수
  @override
  Future<RawSongDto?> getRawSong(String songId) async {
    try {
      final doc = await _firestore.collection('Song').doc(songId).get();
      if (doc.exists && doc.data() != null) {
        return RawSongDto.fromJson(doc.data()!);
      }
      return null;
    } catch (e, stackTrace) {
      print('e: $e, stack: $stackTrace');
      return null;
    }
  }

  @override
  Future<void> updateRawSongByLibrary(RawSongDto rawSongDto) async {
    final doc =
        await _firestore.collection('Song').doc(rawSongDto.video.id).get();
    if (doc.exists) {
      final count = (doc.data() as Map<String, dynamic>)['countLibrary'];
      await _firestore.collection('Song').doc().update(
        {
          'countLibrary': count + 1,
        },
      );
    } else {
      await _firestore
          .collection('Song')
          .doc(rawSongDto.video.id)
          .set(rawSongDto.toJson());
    }
  }

  @override
  Future<void> updateRawSongByPlaylist(RawSongDto rawSongDto) {
    throw UnimplementedError();
  }
}

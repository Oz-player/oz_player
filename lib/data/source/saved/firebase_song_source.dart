import 'package:oz_player/data/dto/firebase_song_dto.dart';

abstract interface class FirebaseSongSource {
  Future<FirebaseSongDTO?> getFirebaseSong(String songId);
}

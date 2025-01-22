import 'package:genius_lyrics/genius_lyrics.dart';

// genius용 함수
// 임시로 작성했습니다 사용하지 않을 시 파일 삭제하셔도 됩니다
Future<void> getList() async {
  Genius genius = Genius(
      accessToken:
          'MTetOtkhRR4oxFkr8FUt4qfhSi3QAahFi-J__X0sG9OcBA8cpj1cmyyWWfPMZyYJ');

  Artist? artist = await genius.searchArtist(
      artistName: 'Eminem', maxSongs: 5, sort: SongsSorting.release_date);
  if (artist != null) {
    for (var song in artist.songs) {
      print(song.title);
    }
  }
  Song? song = await genius.searchSong(artist: 'Sia', title: 'Chandelier');
  if (song != null) {
    print('------------------------------------------');
    print(song.lyrics!.length);
    if (song.lyrics != null) {
      print('not null');
    }
  }
}

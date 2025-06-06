import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/domain/entitiy/video_info_entitiy.dart';
import 'package:oz_player/presentation/providers/login/providers.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/card_position_provider.dart';
import 'package:oz_player/presentation/widgets/loading/loading_view_model/loading_view_model.dart';

class ConditionState {
  List<String> mood;
  Set<int> moodSet;
  List<String> situation;
  Set<int> situationSet;
  List<String> genre;
  Set<int> genreSet;
  List<String> artist;
  Set<int> artistSet;
  int page;
  double opacity;
  bool event;
  List<String> title;
  List<String> subtitle;
  List<SongEntity> recommendSongs;
  List<String> exceptList;

  ConditionState(
      this.mood,
      this.moodSet,
      this.situation,
      this.situationSet,
      this.genre,
      this.genreSet,
      this.artist,
      this.artistSet,
      this.page,
      this.opacity,
      this.event,
      this.title,
      this.subtitle,
      this.recommendSongs,
      this.exceptList);

  ConditionState copyWith({
    List<String>? mood,
    Set<int>? moodSet,
    List<String>? situation,
    Set<int>? situationSet,
    List<String>? genre,
    Set<int>? genreSet,
    List<String>? artist,
    Set<int>? artistSet,
    int? page,
    double? opacity,
    bool? event,
    List<String>? title,
    List<String>? subtitle,
    List<SongEntity>? recommendSongs,
    List<String>? exceptList,
  }) =>
      ConditionState(
          mood ?? this.mood,
          moodSet ?? this.moodSet,
          situation ?? this.situation,
          situationSet ?? this.situationSet,
          genre ?? this.genre,
          genreSet ?? this.genreSet,
          artist ?? this.artist,
          artistSet ?? this.artistSet,
          page ?? this.page,
          opacity ?? this.opacity,
          event ?? this.event,
          title ?? this.title,
          subtitle ?? this.subtitle,
          recommendSongs ?? this.recommendSongs,
          exceptList ?? this.exceptList);
}

class ConditionViewModel extends AutoDisposeNotifier<ConditionState> {
  @override
  ConditionState build() {
    List<String> mood = [
      '행복해요',
      '혼란스러워요',
      '위로가 필요해요',
      '설레요',
      '좌절했어요',
      '신나요',
      '슬퍼요',
      '화나요',
      '기대돼요',
      '피곤해요',
      '불안해요',
      '우울해요',
      '답답해요',
      '걱정돼요',
      '지루해요',
      '차분해요',
      '집중하고 싶어요',
      '공허해요',
    ];
    List<String> situation = [
      '운동',
      '공부·집중',
      '독서',
      '자기 전·수면',
      '산책',
      '요리',
      '파티',
      '목욕·샤워',
      '운전',
      '힐링',
      '데이트',
      '명상',
      '청소',
      '게임',
      '업무',
      '휴가·여행',
    ];
    List<String> genre = [
      'POP',
      'K-POP',
      'J-POP',
      'OST',
      'BGM',
      'R&B',
      '댄스',
      '재즈',
      '힙합',
      '락',
      '발라드',
      '트로트',
      '인디',
      '무반주 음악',
      '클래식',
    ];
    List<String> artist = [
      '보이그룹',
      '걸그룹',
      '남성 솔로',
      '여성 솔로',
      '밴드',
      '혼성 그룹',
      '오케스트라',
      '합창단',
      '상관없음',
    ];
    List<String> title = [
      '지금, 당신의 상태나 기분은\n어떤지 알려주세요',
      '어떤 순간에 어울리는 음악을\n찾으시나요?',
      '원하는 음악 장르를\n선택해주세요',
      '선호하는 아티스트를\n선택해주세요',
    ];
    List<String> subtitle = [
      '당신에게 딱 맞는 음악을 추천해 드릴게요!',
      '하고 있는 일에 몰입감을 더해보세요!',
      '현재 기분에 맞는 음악 장르를 골라요!',
      '마음에 드는 아티스트를 선택해 맞춤화 추천을 받아요!',
    ];
    return ConditionState(mood, {}, situation, {}, genre, {}, artist, {}, 0,
        1.0, false, title, subtitle, [], []);
  }

  void clickBox(int index, Set<int> set) {
    if (set.contains(index)) {
      set.remove(index);
      state.event = false;
    } else {
      set.clear();
      set.add(index);
      state.event = true;
    }

    state = state.copyWith();
  }

  bool nextPage() {
    if (state.page == 0 && state.moodSet.isNotEmpty) {
      nextPageAnimation();
      return false;
    } else if (state.page == 1 && state.situationSet.isNotEmpty) {
      nextPageAnimation();
      return false;
    } else if (state.page == 2 && state.genreSet.isNotEmpty) {
      nextPageAnimation();
      return false;
    } else if (state.page == 3 && state.artistSet.isNotEmpty) {
      nextPageAnimation();
      return true;
    } else {
      return false;
    }
  }

  /// false 값이면 계속 recommend_page_condition_one 페이지
  /// true는 아얘 recommend_page_condition_two 로 이동
  Future<void> nextPageAnimation() async {
    if (state.page < 3) {
      toggleOpacity();
      state = state.copyWith();

      await Future.delayed(Duration(milliseconds: 250));

      state.page += 1;
      state = state.copyWith();

      toggleOpacity();
      state.event = false;

      if (state.page == 0 && state.moodSet.isNotEmpty) {
        state.moodSet.clear();
      } else if (state.page == 1 && state.situationSet.isNotEmpty) {
        state.situationSet.clear();
      } else if (state.page == 2 && state.genreSet.isNotEmpty) {
        state.genreSet.clear();
      } else if (state.page == 3 && state.artistSet.isNotEmpty) {
        state.artistSet.clear();
      }

      state = state.copyWith();
      await Future.delayed(Duration(milliseconds: 250));
    } else {
      return;
    }
  }

  Future<void> beforePageAnimation() async {
    if (state.page > 0) {
      toggleOpacity();
      state = state.copyWith();

      await Future.delayed(Duration(milliseconds: 250));

      state.page -= 1;
      state = state.copyWith();

      toggleOpacity();

      if (state.page == 0 && state.moodSet.isNotEmpty) {
        state.event = true;
      } else if (state.page == 1 && state.situationSet.isNotEmpty) {
        state.event = true;
      } else if (state.page == 2 && state.genreSet.isNotEmpty) {
        state.event = true;
      } else if (state.page == 3 && state.artistSet.isNotEmpty) {
        state.event = true;
      } else {
        state.event = false;
      }

      state = state.copyWith();

      await Future.delayed(Duration(milliseconds: 250));
    }
  }

  void toggleOpacity() {
    state.opacity = state.opacity == 1.0 ? 0.0 : 1.0;
  }

  /// Gemini 한테 태그를 기반으로한 음악을 검색해달라고 요청
  /// 응답받은 값(musicName, artist)으로 maniadb 검색
  /// 응답받은 값(musicName, artist)으로 video 검색
  /// 검색 값 저장 및 출력
  /// 만약 검색후에 나온 결과값이 아무것도 나오지 않을 경우엔? 대응 필요
  Future<void> recommendMusic() async {
    // 검색 시작전 초기화
    state.recommendSongs = [];

    final gemini = ref.read(geiminiRepositoryProvider);
    // final videoEx = ref.read(videoInfoUsecaseProvider);
    // final maniaDBSong = ref.read(maniadbSongUsecaseProvider);
    // final maniaDBArtist = ref.read(maniadbArtistUsecaseProvider);
    final spotifyDB = ref.read(spotifySourceProvider);
    ref.read(loadingViewModelProvider.notifier).startLoading(1);

    final apiKey = dotenv.env['GEMINI_KEY'];
    final num = 5;
    final moodlist = state.moodSet.map((e) => state.mood[e]).toList();
    final situationlist =
        state.situationSet.map((e) => state.situation[e]).toList();
    final genrelist = state.genreSet.map((e) => state.genre[e]).toList();
    final artistlist = state.artistSet.map((e) => state.artist[e]).toList();
    final exceptlist = state.exceptList.join('\n');
    final moodtext = moodlist.join(', ');
    final situationtext = situationlist.join(', ');
    final genretext = genrelist.join(', ');
    final artisttext = artistlist.join(', ');
    final condition = '''
1. 지금 나의 기분은 '$moodtext'
2. 지금 내가 하고 있는것은 '$situationtext'
3. 추천 받고 싶은 노래의 장르는 '$genretext'
4. 선호하는 아티스트는 '$artisttext'
''';

    final except = '''
$exceptlist
''';

    final result = await gemini.recommentMultiMusicByGemini(
        condition, apiKey!, num, except);

    // 응답받은 값(musicName, artist)으로 maniadb 검색
    // 응답받은 값(musicName, artist)으로 video 검색
    for (int i = 0; i < result.length; i++) {
      final title = result[i].musicName;
      final artist = result[i].artist;

      log('title : $title');
      log('title : $artist');

      String? imgUrl;

      try {
        /* ManiaDB로 imgUrl 가져오는 로직
        final searchSong = await maniaDBSong.execute(title!);

        for (var i in searchSong!) {
          if (i.artist['name'] == artist) {
            final searchArtist = await maniaDBArtist.execute(artist!);
            imgUrl = searchArtist![0].image;

            if (imgUrl.isEmpty) {
              log('imgUrl : 불러오기 실패');
            } else {
              log('imgUrl : $imgUrl');
            }
            break;
          }
        }
        */

        final searchSong = await spotifyDB.searchList('$artist - $title}');
        final album = searchSong[0].album;
        final albumImges = album!['images'][0];
        imgUrl = albumImges['url'];

        log('$title - $artist 검색성공');
        /*
        final video = await videoEx.getVideoInfo(title!, artist!);

        if (video.audioUrl == '' && video.id == '') {
          throw '$title - Video is EMPTY';
        }
        */

        final video = VideoInfoEntitiy.empty();

        final song = SongEntity(
          video: video,
          title: title!,
          imgUrl: imgUrl ?? '',
          artist: artist!,
          mood: moodtext,
          situation: situationtext,
          genre: genretext,
          favoriteArtist: artisttext,
        );

        state.recommendSongs.add(song);
      } catch (e) {
        log('$e');
        log('$title - $artist 는 오디오 불러로는것을 실패, 스킵');
      } finally {
        // 추천항목에서 재 추천이 되지 않도록 예외 리스트에 넣기
        state.exceptList.add('$artist - $title');
      }
    }

    // 검색 결과값이 없을 경우 (대응 고민)
    if (state.recommendSongs.isEmpty) {}

    ref.read(cardPositionProvider.notifier).cardPositionIndex(0);
    ref.read(loadingViewModelProvider.notifier).endLoading();
  }
}

final conditionViewModelProvider =
    AutoDisposeNotifierProvider<ConditionViewModel, ConditionState>(() {
  return ConditionViewModel();
});

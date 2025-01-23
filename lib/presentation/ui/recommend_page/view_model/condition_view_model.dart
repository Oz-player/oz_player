import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/providers/login/providers.dart';
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
      this.subtitle);

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
          subtitle ?? this.subtitle);
}

class ConditionViewModel extends AutoDisposeNotifier<ConditionState> {
  @override
  ConditionState build() {
    List<String> mood = [
      '행복해요',
      '혼란스러워요',
      '위로가 필요해요',
      '설레요',
      '고민중이에요',
      '좌절했어요',
      '신나요',
      '슬퍼요',
      '화나요',
      '기대되요',
      '피곤해요',
      '불안해요',
      '답답해요',
      '걱정되요',
      '지루해요',
    ];
    List<String> situation = [
      '운동',
      '공부·집중',
      '독서',
      '티 타임',
      '자기 전·자면서',
      '산책',
      '요리',
      '파티',
      '목욕·샤워',
      '운전',
      '힐링',
      '식사',
      '데이트',
      '명상',
    ];
    List<String> genre = [
      'POP',
      '국내 가요',
      '외국 가요',
      '재즈',
      '락',
      '클래식',
      '무반주 음악',
      'BGM',
      'EDM',
      '댄스',
      '발라드',
      '트로트',
      '인디',
      '힙합',
      'OST',
      '동요',
      'R&B',
    ];
    List<String> artist = [
      '보이그룹',
      '걸그룹',
      '혼성 아티스트',
      '남성 솔로',
      '여성 솔로',
      '유닛',
      '밴드',
      '전자 음악 제작자',
      '오케스트라',
      '악기 연주자',
      '합창단',
    ];
    List<String> title = [
      '지금, 당신의 상태나 기분은\n어떤지 알려주세요',
      '어떤 순간에 어울리는 음악을\n찾으시나요?',
      '원하는 음악 장르를\n선택해주세요',
      '선호하는 아티스트를\n선택해주세요',
    ];
    List<String> subtitle = [
      '최대 3개 까지 선택이 가능해요!',
      '하고 있는 일에 몰입감을 더해보세요!',
      '현재 기분에 맞는 음악 장르를 골라요!',
      '마음에 드는 아티스트를 선택해 맞춤화 추천을 받아요!',
    ];
    return ConditionState(mood, {}, situation, {}, genre, {}, artist, {}, 0,
        1.0, false, title, subtitle);
  }

  void clickBox(int index, Set<int> set) {
    if (state.page == 0) {
      if (set.contains(index)) {
        set.remove(index);
      } else {
        if (set.length < 3) {
          set.add(index);
        }
      }

      state = state.copyWith();
    } else {
      if (set.contains(index)) {
        set.remove(index);
      } else {
        set.clear();
        set.add(index);
      }

      state = state.copyWith();
    }
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
      state.event = true;
      toggleOpacity();
      state = state.copyWith();

      await Future.delayed(Duration(milliseconds: 250));

      state.page += 1;
      state = state.copyWith();

      toggleOpacity();
      state = state.copyWith();

      await Future.delayed(Duration(milliseconds: 250));
      state.event = false;
    } else {
      return;
    }
  }

  Future<void> beforePageAnimation() async {
    if (state.page > 0) {
      state.event = true;
      toggleOpacity();
      state = state.copyWith();

      await Future.delayed(Duration(milliseconds: 250));

      state.page -= 1;
      state = state.copyWith();

      toggleOpacity();
      state = state.copyWith();

      await Future.delayed(Duration(milliseconds: 250));
      state.event = false;
    }
  }

  void toggleOpacity() {
    state.opacity = state.opacity == 1.0 ? 0.0 : 1.0;
  }

  /// Gemini 한테 태그를 기반으로한 음악을 검색해달라고 요청
  /// 응답받은 값(musicName, artist)으로 maniadb 검색
  /// 응답받은 값(musicName, artist)으로 video 검색
  /// 검색 값 저장 및 출력
  Future<void> recommendMusic() async {
    final gemini = ref.read(geiminiRepositoryProvider);
    ref.read(loadingViewModelProvider.notifier).startLoading();

    final apiKey = dotenv.env['GEMINI_KEY'];
    final num = 5;
    final moodtext =
        state.moodSet.map((e) => state.mood[e]).toList().join(', ');
    final situationtext =
        state.situationSet.map((e) => state.situation[e]).toList().join(', ');
    final genretext =
        state.genreSet.map((e) => state.genre[e]).toList().join(', ');
    final artisttext =
        state.artistSet.map((e) => state.artist[e]).toList().join(', ');
    final condition = '''
1. 지금 나의 기분은 '$moodtext'
2. 지금 내가 하고 있는것은 '$situationtext'
3. 추천 받고 싶은 노래의 장르는 '$genretext'
4. 선호하는 아티스트는 '$artisttext'
''';

    final except = '''백예린 - 혼란스러워''';

    final result = await gemini.recommentMultiMusicByGemini(
        condition, apiKey!, num, except);

    ref.read(loadingViewModelProvider.notifier).endLoading();
  }
}

final conditionViewModelProvider =
    AutoDisposeNotifierProvider<ConditionViewModel, ConditionState>(() {
  return ConditionViewModel();
});

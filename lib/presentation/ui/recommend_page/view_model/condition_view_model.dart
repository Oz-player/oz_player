import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConditionState {
  List<String> mood;
  Set<int> moodSet;
  List<String> situation;
  Set<int> situationSet;
  List<String> genre;
  Set<int> genreSet;
  List<String> artist;
  Set<int> artistSet;

  ConditionState(this.mood, this.moodSet, this.situation, this.situationSet,
      this.genre, this.genreSet, this.artist, this.artistSet);

  ConditionState copyWith({
    List<String>? mood,
    Set<int>? moodSet,
    List<String>? situation,
    Set<int>? situationSet,
    List<String>? genre,
    Set<int>? genreSet,
    List<String>? artist,
    Set<int>? artistSet,
  }) =>
      ConditionState(
          mood ?? this.mood,
          moodSet ?? this.moodSet,
          situation ?? this.situation,
          situationSet ?? this.situationSet,
          genre ?? this.genre,
          genreSet ?? this.genreSet,
          artist ?? this.artist,
          artistSet ?? this.artistSet);
}

class ConditionViewModel extends Notifier<ConditionState> {
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
    return ConditionState(mood, {}, situation, {}, genre, {}, artist, {});
  }

  void clickBox(int index, Set<int> set){
    
    if(set.contains(index)){
      set.remove(index);
    } else {
      set.add(index);
    }

    state = state.copyWith();
  }
}

final conditionViewModelProvider =
    NotifierProvider<ConditionViewModel, ConditionState>(() {
  return ConditionViewModel();
});

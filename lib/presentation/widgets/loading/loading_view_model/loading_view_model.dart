import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingState {
  bool isLoading;
  List<String> loadingText;
  int index;
  List<String> loadingImage;

  LoadingState(this.isLoading, this.loadingText, this.index, this.loadingImage);

  LoadingState copyWith({
    bool? isLoading,
    List<String>? loadingText,
    int? index,
    List<String>? loadingImage,
  }) =>
      LoadingState(isLoading ?? this.isLoading, loadingText ?? this.loadingText,
          index ?? this.index, loadingImage ?? this.loadingImage);
}

class LoadingViewModel extends Notifier<LoadingState> {
  @override
  LoadingState build() {
    List<String> loadingText = [
      '',
      '추천 음악 카드를 준비 중\n잠시만 기다려주세요',
      '음악 카드를 보관함에 저장하는 중\n잠시만 기다려주세요',
      '새로운 플레이리스트를 생성하는 중\n잠시만 기다려주세요',
      '플레이리스트에 음악을 저장하는 중\n잠시만 기다려주세요'
    ];

    List<String> loadingImage = [
      '',
      'assets/char/oz_loading1.png',
      'assets/char/oz_loading1.png',
      'assets/char/oz_loading2.png',
      'assets/char/oz_loading2.png',
    ];

    return LoadingState(false, loadingText, 0, loadingImage);
  }

  void startLoading(int index) {
    state = state.copyWith(isLoading: true, index: index);
  }

  void endLoading() {
    state = state.copyWith(isLoading: false, index: 0);
  }
}

final loadingViewModelProvider =
    NotifierProvider<LoadingViewModel, LoadingState>(() {
  return LoadingViewModel();
});

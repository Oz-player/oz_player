import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingState {
  bool isLoading;
  List<String> loadingText;
  int index;

  LoadingState(this.isLoading, this.loadingText, this.index);

  LoadingState copyWith({
    bool? isLoading,
    List<String>? loadingText,
    int? index,
  }) =>
      LoadingState(isLoading ?? this.isLoading, loadingText ?? this.loadingText,
          index ?? this.index);
}

class LoadingViewModel extends Notifier<LoadingState> {
  @override
  LoadingState build() {
    List<String> loadingText = [
      '',
      '추천 음악 카드를 준비중\n잠시만 기다려주세요',
    ];

    return LoadingState(false, loadingText, 0);
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

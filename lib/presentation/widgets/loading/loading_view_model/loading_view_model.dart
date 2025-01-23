import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingState {
  bool isLoading;

  LoadingState(this.isLoading);
}

class LoadingViewModel extends Notifier<LoadingState>{
  @override
  LoadingState build() {
    return LoadingState(false);
  }

  void startLoading(){
    state = LoadingState(true);
  }

  void endLoading(){
    state = LoadingState(false);
  }
}

final loadingViewModelProvider = NotifierProvider<LoadingViewModel,LoadingState>((){
  return LoadingViewModel();
});
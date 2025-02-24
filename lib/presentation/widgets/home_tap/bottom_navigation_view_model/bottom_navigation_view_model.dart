import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationViewModel extends StateNotifier<int> {
  BottomNavigationViewModel() : super(1);

  void updatePage(int index){
    state = index;
  }

  void resetPage(){
    state = 1;
  }
}

final bottomNavigationProvider =
    StateNotifierProvider<BottomNavigationViewModel, int>(
  (ref) => BottomNavigationViewModel(),
);

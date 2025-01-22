import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationViewModel extends StateNotifier<int> {
  BottomNavigationViewModel() : super(0);

  void updatePage(int index){
    state = index;
  }
}

final bottomNavigationProvider =
    StateNotifierProvider<BottomNavigationViewModel, int>(
  (ref) => BottomNavigationViewModel(),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextBoxWidgetsState {
  List<String> textList;
  int index;

  TextBoxWidgetsState({required this.textList, required this.index});
}

class TextBoxWidgetsViewModel extends AutoDisposeNotifier<TextBoxWidgetsState> {
  @override
  TextBoxWidgetsState build() {
    final textList = [
      '안녕하세요\n저는 마법사 오즈라고 해요',
      '원하는 음악이 나오면 저장하고,\n원하지 않는 음악이 나오면\n다른 카드로 넘겨주세요!'
    ];
    return TextBoxWidgetsState(textList: textList, index: 0);
  }

  void nextText(){
    state = TextBoxWidgetsState(textList: state.textList, index: 1);
  }
}

final textBoxWidgetsViewModelProvider = AutoDisposeNotifierProvider<TextBoxWidgetsViewModel,TextBoxWidgetsState>((){
  return TextBoxWidgetsViewModel();
});

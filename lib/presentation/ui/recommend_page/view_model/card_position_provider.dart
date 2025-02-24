import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardPositionProvider extends StateNotifier<int>{
  CardPositionProvider() : super(0);

  void cardPositionIndex(int index){
    state = index;
  }

  void reset(){
    state = 0;
  }
}

final cardPositionProvider = StateNotifierProvider<CardPositionProvider,int>((ref){
  return CardPositionProvider();
});
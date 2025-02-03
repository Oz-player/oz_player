import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/card_position_provider.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/save_song_bottom_sheet_view_model.dart';
import 'package:oz_player/presentation/widgets/card_widget/card_widget.dart';
import 'package:oz_player/presentation/widgets/loading/loading_view_model/loading_view_model.dart';

class SaveSongBottomSheet {
  static void show(BuildContext context, WidgetRef ref,
      TextEditingController textController) async {
    final openSheet = await showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: true,
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Consumer(
              builder: (context, ref, child) {
                final saveState = ref.watch(saveSongBottomSheetViewModelProvider);
                final loading = ref.watch(loadingViewModelProvider).isLoading;
                
                if (saveState.blind) {
                  return SizedBox.shrink();
                }
                if (saveState.page == 0) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                    ),
                    child: Wrap(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                              width: double.maxFinite,
                            ),
                            Container(
                              height: 5,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[400],
                              ),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Text(
                              '이 음악을 나의\n라이브러리에 저장',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '앞에서 선택한 현재 상태와 기분이 같이 기록돼요!',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...List.generate(1, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: Color(0xfff2e6ff)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 10),
                                        child: Text(
                                          saveState.savedSong!.mood,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            CardWidget(
                              title: saveState.savedSong!.title,
                              artist: saveState.savedSong!.artist,
                              imgUrl: saveState.savedSong!.imgUrl,
                              isShade: true,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: 100,
                              height: 48,
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.grey[800]),
                                ),
                                onPressed: () {
                                  ref
                                      .read(saveSongBottomSheetViewModelProvider
                                          .notifier)
                                      .nextPage();
                                },
                                child: Text(
                                  '다음',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(height: 84),
                          ],
                        )
                      ],
                    ),
                  );
                } else if (saveState.page == 1) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                    ),
                    child: Wrap(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                              width: double.maxFinite,
                            ),
                            Container(
                              height: 5,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[400],
                              ),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Text(
                              '카드에 남길 메모를\n적어주세요',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '지금 떠오르는 생각을 자유롭게 적어보세요',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color(0xff7303E3)),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 37.5),
                              child: SizedBox(
                                height: 140,
                                child: TextField(
                                  controller: textController,
                                  onChanged: (value) {
                                    ref
                                        .read(saveSongBottomSheetViewModelProvider
                                            .notifier)
                                        .reflash();
                                  },
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                  ),
                                  maxLines: 6,
                                  cursorWidth: 2.0,
                                  cursorHeight: 20.0,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      hintText: '메모 추가',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[600]),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            SizedBox(
                              width: 160,
                              height: 48,
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  backgroundColor: WidgetStatePropertyAll(
                                      textController.text.isEmpty
                                          ? Colors.grey[300]
                                          : Colors.grey[800]),
                                ),
                                onPressed: () async {
                                  if (loading) {
                                    return;
                                  }
            
                                  if (textController.text.isEmpty) {
                                    return;
                                  } else {
                                    ref.read(saveSongBottomSheetViewModelProvider.notifier).isBlind();
                                    
                                    ref
                                        .read(loadingViewModelProvider.notifier)
                                        .startLoading(2);
            
                                    ref
                                        .read(saveSongBottomSheetViewModelProvider
                                            .notifier)
                                        .setMemoInSong(textController.text);
                                    // 카드 정보 보관함에 넘기기
            
                                    await ref
                                        .read(saveSongBottomSheetViewModelProvider
                                            .notifier)
                                        .saveSongInDB();
                                    await ref
                                        .read(saveSongBottomSheetViewModelProvider
                                            .notifier)
                                        .saveSongInLibrary();
            
                                    if (context.mounted) {
                                      context.pop();
                                    }
                                    ref
                                        .read(cardPositionProvider.notifier)
                                        .cardPositionIndex(0);
                                    ref
                                        .read(loadingViewModelProvider.notifier)
                                        .endLoading();
                                  }
                                },
                                child: Text(
                                  '카드 저장하기',
                                  style: TextStyle(
                                      color: textController.text.isEmpty
                                          ? Colors.grey[400]
                                          : Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          );
        });

    /// 드래그로 닫을 경우 호출됨
    if (openSheet == null) {
      await Future.delayed(Duration(milliseconds: 500));
      ref.read(saveSongBottomSheetViewModelProvider.notifier).resetPage();
      textController.text = '';
    }
  }
}

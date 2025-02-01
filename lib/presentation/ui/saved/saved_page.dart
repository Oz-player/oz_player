import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/view_models/list_sort_viewmodel.dart';
import 'package:oz_player/presentation/ui/saved/widgets/library.dart';
import 'package:oz_player/presentation/ui/saved/widgets/play_list.dart';
import 'package:oz_player/presentation/ui/saved/widgets/saved_tab_button.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

// enum SortedType {
//   final String string;
//   latest(string: '최근 저장 순'), ascending(string: '가나다순');
//   const SortedType({required this.string});
//   }

class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  ConsumerState<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage> {
  bool isLibrary = true;
  bool isOverlayOn = false;

  void onButtonClicked() {
    setState(() {
      isLibrary = !isLibrary;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //ref.read(listSortViewModelProvider.notifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(listSortViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '보관함',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ----------
                // 상단 이미지
                // ----------
                Stack(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.gray300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Positioned(
                      top: 35,
                      left: 24,
                      child: Text(
                        isLibrary
                            ? '오즈의 음악 카드에 적어놓은\n메모도 확인해봐라냐옹'
                            : '나만의 플레이리스트를 마음껏\n만들어봐라냐옹',
                        style: TextStyle(
                            color: AppColors.gray900,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset('assets/char/myu_2.png')),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),
                // 탭 이동 버튼
                Row(
                  children: [
                    SavedTabButton(
                      title: '라이브러리',
                      isLibrary: isLibrary,
                      onClicked: onButtonClicked,
                    ),
                    SavedTabButton(
                      title: '플레이리스트',
                      isLibrary: !isLibrary,
                      onClicked: onButtonClicked,
                    ),
                  ],
                ),
                // ---------------
                // 정렬 기준 박스
                // ---------------
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.main100,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ref.watch(listSortViewModelProvider).stateString,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isOverlayOn = !isOverlayOn;
                            });
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                            ),
                            child: Icon(
                              !isOverlayOn
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                              color: AppColors.main600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 내용
                isLibrary ? Library() : PlayList(),
              ],
            ),
          ),
          Positioned(
            top: 226,
            left: 20,
            child: SizedBox(
              child: isOverlayOn
                  ? Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              viewModel.setLatest();
                              isOverlayOn = false;
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                color: ref.watch(listSortViewModelProvider) ==
                                        SortedType.latest
                                    ? AppColors.main100
                                    : Colors.white,
                                child: Text(
                                  '최근 저장 순',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              viewModel.setAscending();
                              isOverlayOn = false;
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                color: ref.watch(listSortViewModelProvider) ==
                                        SortedType.ascending
                                    ? AppColors.main100
                                    : Colors.white,
                                child: Text(
                                  '가나다순',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  : null,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: AudioPlayer(
              colorMode: true,
            ),
          ),
        ],
      ),
      bottomNavigationBar: HomeBottomNavigation(),
    );
  }
}

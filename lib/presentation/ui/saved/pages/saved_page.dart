import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/view_models/list_sort_viewmodel.dart';
import 'package:oz_player/presentation/ui/saved/widgets/create_playlist_button.dart';
import 'package:oz_player/presentation/ui/saved/widgets/library.dart';
import 'package:oz_player/presentation/ui/saved/widgets/play_list.dart';
import 'package:oz_player/presentation/ui/saved/widgets/saved_tab_button.dart';
import 'package:oz_player/presentation/ui/saved/widgets/sorted_type_box.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  ConsumerState<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage> {
  bool isLibrary = true; // 라이브러리 - 플레이리스트 탭 전환
  bool isOverlayOn = false; // 드롭다운 오버레이 표시 여부
  final title = TextEditingController(); // 플레이리스트 생성창 제목 컨트롤러
  final description = TextEditingController(); // 플레이리스트 생성창 내용 컨트롤러

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  void onButtonClicked() {
    setState(() {
      isLibrary = !isLibrary;
    });
  }

  void setOverlayOn() {
    setState(() {
      isOverlayOn = !isOverlayOn;
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
                // ----------------------------------------------------------
                // 상단 이미지
                // ----------------------------------------------------------
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
                // ----------------------------------------------------------
                // 탭 이동 버튼
                // ----------------------------------------------------------
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
                // ----------------------------------------------------------
                // 정렬 기준 박스
                // ----------------------------------------------------------
                SortedTypeBox(
                  ref: ref,
                  isOverlayOn: isOverlayOn,
                  setOverlayOn: setOverlayOn,
                ),
                // ----------------------------------------------------------
                // 보관함 내용
                // ----------------------------------------------------------
                isLibrary ? Library() : PlayList(),
              ],
            ),
          ),
          // ----------------------------------------------------------
          // 정렬 방법 선택용 드롭다운
          // ----------------------------------------------------------
          Positioned(
            top: 250,
            left: 20,
            child: SizedBox(
              width: 110,
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
                                width: 100,
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
                                    fontSize: 14,
                                    color:
                                        ref.watch(listSortViewModelProvider) ==
                                                SortedType.latest
                                            ? AppColors.main600
                                            : AppColors.gray600,
                                  ),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              viewModel.setAscending();
                              isOverlayOn = false;
                            },
                            child: Container(
                                width: 100,
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
                                    fontSize: 14,
                                    color:
                                        ref.watch(listSortViewModelProvider) ==
                                                SortedType.ascending
                                            ? AppColors.main600
                                            : AppColors.gray600,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ----------------------------------------------------------
                // 플레이리스트 새로 만들기 버튼
                // ----------------------------------------------------------
                if (!isLibrary)
                  CreatePlaylistButton(title: title, description: description),
                const SizedBox(
                  height: 12,
                ),
                // ----------------------------------------------------------
                // 오디오 박스
                // ----------------------------------------------------------
                AudioPlayer(
                  colorMode: true,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: HomeBottomNavigation(),
    );
  }
}

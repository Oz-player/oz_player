import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/widgets/library.dart';
import 'package:oz_player/presentation/ui/saved/widgets/play_list.dart';
import 'package:oz_player/presentation/ui/saved/widgets/saved_tab_button.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

enum SortedType { latest, ascending }

class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  ConsumerState<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage> {
  bool isLibrary = true;
  SortedType sortedType = SortedType.latest;

  void onButtonClicked() {
    setState(() {
      isLibrary = !isLibrary;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
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
                          '오즈의 음악 카드에 적어놓은\n메모도 확인해봐라냐옹',
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
                const SizedBox(
                  height: 16,
                ),
                // 정렬 기준
                Container(
                  width: 124,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.main100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '최근 저장 순',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('tap');
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.main600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                // 내용
                isLibrary ? Library() : PlayList(),
              ],
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

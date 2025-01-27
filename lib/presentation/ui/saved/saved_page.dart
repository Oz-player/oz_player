import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_view_model.dart';
import 'package:oz_player/presentation/ui/saved/widgets/saved_tab_button.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  ConsumerState<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage> {
  bool isLibrary = true;

  @override
  void initState() {
    super.initState();
    // TODO : DB 정리하고 나서 데이터 뿌리기
    // Future.microtask(() async {
    //   await ref.read(playListViewModelProvider.notifier).getPlayLists('userId');
    // });
  }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(
              width: 340,
              height: 40,
              child: Row(
                children: [
                  Text(
                    '정렬 기준',
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
                      width: 40,
                      height: 40,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey[300],
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey[500],
                        ),
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
            SizedBox(
              width: double.infinity,
              height: 586,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // 플레이리스트 대표 이미지
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.grey[600],
                              ),
                            ),
                            // 플레이리스트 내용
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '플레이리스트 이름 플레이리스트 이름',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '00개의 곡',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 메뉴 버튼
                      GestureDetector(
                        onTap: () {
                          print('tap');
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          color: Colors.transparent,
                          child: Icon(Icons.more_vert),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavigation(),
    );
  }
}

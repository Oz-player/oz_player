import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/saved/playlist_page.dart';
import 'package:oz_player/presentation/ui/saved/view_models/list_sort_viewmodel.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_view_model.dart';
import 'package:oz_player/presentation/ui/saved/widgets/delete_alert_dialog.dart';

class PlayList extends ConsumerStatefulWidget {
  const PlayList({
    super.key,
  });

  @override
  ConsumerState<PlayList> createState() => _PlayListState();
}

class _PlayListState extends ConsumerState<PlayList> {
  SortedType sortedType = SortedType.latest;

  @override
  Widget build(BuildContext context) {
    final playListAsync = ref.watch(playListViewModelProvider);
    // --------------------------------------------
    // 플레이리스트
    // --------------------------------------------
    return playListAsync.when(
      data: (data) {
        if (data.isEmpty) {
          return Image.asset('assets/images/playlist_empty.png');
        }
        return Flexible(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                // 플레이리스트 선택 시 해당 플레이리스트의 songIds로
                // PlayListSongNotifier 상태 업데이트
                return GestureDetector(
                  onTap: () {
                    context.go(
                      '/saved/playlist',
                      extra: data[index],
                    );
                  },
                  // 터치 가능 영역 확장하기 위해 Expanded 사용
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    height: 80,
                    color: Colors.transparent,
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
                                  image: data[index].imgUrl == null
                                      ? DecorationImage(
                                          image: AssetImage(
                                              'assets/images/muoz.png'),
                                          fit: BoxFit.contain)
                                      : DecorationImage(
                                          image:
                                              NetworkImage(data[index].imgUrl!),
                                        ),
                                ),
                              ),
                              // 플레이리스트 내용
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index].listName,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '${data[index].songIds.length}개의 곡',
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
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (context) => Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            // -----------------------
                                            // bottomsheet - 노래 이미지
                                            // -----------------------
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: data[index].imgUrl == null
                                                  ? Image.asset(
                                                      'assets/images/muoz.png',
                                                      width: 48,
                                                      height: 48,
                                                      fit: BoxFit.scaleDown,
                                                    )
                                                  : Image.network(
                                                      data[index].imgUrl!,
                                                      width: 48,
                                                      height: 48,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            // ---------------------
                                            // bottomsheet - 노래 제목
                                            // ---------------------
                                            Expanded(
                                              child: Text(
                                                data[index].listName,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            // ---------------------
                                            // bottomsheet - 종료 버튼
                                            // ---------------------
                                            GestureDetector(
                                              onTap: () => context.pop(),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                width: 48,
                                                height: 48,
                                                color: Colors.transparent,
                                                child: Icon(Icons.close),
                                              ),
                                            )
                                          ],
                                        ),
                                        // -------------------
                                        // 음악 세부 메뉴
                                        // -------------------
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        // 음악 재생
                                        BottomSheetMenuButton(title: '재생'),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        // 음악을 다른 플레이리스트에 저장
                                        BottomSheetMenuButton(
                                          title: '셔플 재생',
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        // 음악 삭제
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) =>
                                                  DeletePlayListAlertDialog(
                                                listName: data[index].listName,
                                              ),
                                            );
                                          },
                                          child: BottomSheetMenuButton(
                                              title: '플레이리스트 삭제'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
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
                );
              }),
        );
      },
      error: (error, stackTrace) => Container(),
      loading: () => Container(),
    );
  }
}

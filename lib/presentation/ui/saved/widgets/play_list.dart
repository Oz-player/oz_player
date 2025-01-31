import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_view_model.dart';
import 'package:oz_player/presentation/ui/saved/view_models/raw_song_view_model.dart';

class PlayList extends ConsumerStatefulWidget {
  const PlayList({
    super.key,
  });

  @override
  ConsumerState<PlayList> createState() => _PlayListState();
}

class _PlayListState extends ConsumerState<PlayList> {
  @override
  Widget build(BuildContext context) {
    final playListAsync = ref.watch(playListViewModelProvider);

    return SizedBox(
      width: double.infinity,
      height: 586,
      child: playListAsync.when(
          data: (data) {
            if (data.isEmpty) {
              return Text('null');
            }
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  // 플레이리스트 선택 시 해당 플레이리스트의 songIds로
                  // rawSongViewModel 상태 업데이트
                  return GestureDetector(
                    onTap: () {
                      ref
                          .read(rawSongViewModelProvider.notifier)
                          .getRawSongs(data[index].songIds);
                      context.go('/saved/playlist');
                    },
                    child: Container(
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
                                    image: DecorationImage(
                                      image: NetworkImage(data[index].imgUrl),
                                    ),
                                  ),
                                ),
                                // 플레이리스트 내용
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                  );
                });
          },
          error: (error, stackTrace) => Container(),
          loading: () => Container()),
    );
  }
}

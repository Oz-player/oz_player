import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_songs_provider.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class EditPlaylistPage extends ConsumerStatefulWidget {
  final PlayListEntity playlist;

  const EditPlaylistPage({super.key, required this.playlist});

  @override
  ConsumerState<EditPlaylistPage> createState() => _EditPlaylistPageState();
}

class _EditPlaylistPageState extends ConsumerState<EditPlaylistPage> {
  final listNameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref
          .watch(playlistSongsProvider.notifier)
          .loadSongs(widget.playlist.songIds);
    });
  }

  @override
  void dispose() {
    listNameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // 곡을 삭제할 때 songId를 삭제한 뒤 플레이리스트 화면 reload 하는 함수
  void removeSongId(String songId) {
    setState(() {
      widget.playlist.songIds.remove(songId);
    });
    print('length: ${widget.playlist.songIds.length}');
    ref
        .watch(playlistSongsProvider.notifier)
        .loadSongs(widget.playlist.songIds);
  }

  @override
  Widget build(BuildContext context) {
    var songListAsync = ref.watch(playlistSongsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          // --------------------
          // 완료 버튼
          // --------------------
          child: GestureDetector(
            onTap: () {
              // TODO : 플레이리스트 업데이트하는 로직
              context.pop();
            },
            child: Container(
              alignment: Alignment.center,
              width: 44,
              height: 44,
              color: Colors.transparent,
              child: Text(
                '완료',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -------------------
                // 플레이리스트 대표 이미지
                // -------------------
                Container(
                  width: double.infinity,
                  height: 140,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: widget.playlist.imgUrl == null
                              ? DecorationImage(
                                  image: AssetImage('assets/images/muoz.png'))
                              : DecorationImage(
                                  image: NetworkImage(widget.playlist.imgUrl!)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                      color: AppColors.main300,
                      width: 1,
                    )),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------------
                      // 플레이리스트 제목
                      // ---------------
                      TextField(
                        controller: listNameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: widget.playlist.listName,
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            )),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // ---------------
                      // 플레이리스트 설명
                      // ---------------
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: widget.playlist.description,
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.gray600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                // ---------------
                // 음악 목록
                // ---------------
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: songListAsync.when(
                    data: (data) {
                      if (data.isEmpty) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Image.asset(
                                  'assets/images/no_songs_in_playlist.png'),
                            ),
                          ],
                        );
                      }
                      return ReorderableListView.builder(
                        itemBuilder: (context, index) => Container(
                          key: Key('$index'),
                          width: double.infinity,
                          height: 72,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReorderableDelayedDragStartListener(
                                  index: index,
                                  child: Container(
                                    width: 44,
                                    height: 44,
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                        'assets/images/list_drag_icon.png'),
                                  )),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // ---------
                                    // 곡 이미지
                                    // ---------
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppColors.gray600,
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(data[index].imgUrl),
                                        ),
                                      ),
                                    ),
                                    // -------
                                    // 곡 내용
                                    // -------
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
                                              data[index].title,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              data[index].artist,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppColors.gray600,
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
                              // -------------
                              // 메뉴 버튼
                              // -------------
                              GestureDetector(
                                onTap: () {},
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
                        itemCount: data.length,
                        onReorder: (int start, int current) {
                          if (start < current) {
                            int end = current - 1;
                            String startItem = widget.playlist.songIds[start];
                            int i = 0;
                            int local = start;
                            do {
                              widget.playlist.songIds[local] =
                                  widget.playlist.songIds[++local];
                              i++;
                            } while (i < end - start);
                            widget.playlist.songIds[end] = startItem;
                          }
                          // dragging from bottom to top
                          else if (start > current) {
                            String startItem = widget.playlist.songIds[start];
                            for (int i = start; i > current; i--) {
                              widget.playlist.songIds[i] =
                                  widget.playlist.songIds[i - 1];
                            }
                            widget.playlist.songIds[current] = startItem;
                          }
                          setState(() {});
                        },
                      );
                      // return ListView.separated(
                      //   itemCount: data.length,
                      //   separatorBuilder: (context, index) => Container(
                      //     width: double.infinity,
                      //     height: 1,
                      //     color: AppColors.border,
                      //   ),
                      //   itemBuilder: (context, index) {
                      //     return Container(
                      //       padding: EdgeInsets.symmetric(vertical: 12),
                      //       width: double.infinity,
                      //       height: 72,
                      //       color: Colors.transparent,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Expanded(
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               children: [
                      //                 Container(
                      //                   padding: const EdgeInsets.all(10),
                      //                   width: 44,
                      //                   height: 44,
                      //                   child: Image.asset(
                      //                       'assets/images/list_drag_icon.png'),
                      //                 ),
                      //                 // ---------
                      //                 // 곡 이미지
                      //                 // ---------
                      //                 Container(
                      //                   width: 48,
                      //                   height: 48,
                      //                   decoration: BoxDecoration(
                      //                     borderRadius:
                      //                         BorderRadius.circular(4),
                      //                     color: AppColors.gray600,
                      //                     image: DecorationImage(
                      //                       image: NetworkImage(
                      //                           data[index].imgUrl),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 // -------
                      //                 // 곡 내용
                      //                 // -------
                      //                 Expanded(
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.symmetric(
                      //                         horizontal: 18),
                      //                     child: Column(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Text(
                      //                           data[index].title,
                      //                           overflow: TextOverflow.ellipsis,
                      //                           style: TextStyle(
                      //                             fontWeight: FontWeight.w600,
                      //                             fontSize: 16,
                      //                           ),
                      //                         ),
                      //                         Text(
                      //                           data[index].artist,
                      //                           overflow: TextOverflow.ellipsis,
                      //                           style: TextStyle(
                      //                             color: AppColors.gray600,
                      //                             fontWeight: FontWeight.w500,
                      //                             fontSize: 14,
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           // -------------
                      //           // 메뉴 버튼
                      //           // -------------
                      //           GestureDetector(
                      //             onTap: () {},
                      //             child: Container(
                      //               width: 44,
                      //               height: 44,
                      //               color: Colors.transparent,
                      //               child: Icon(Icons.more_vert),
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // );
                    },
                    error: (error, stackTrace) {
                      return Container();
                    },
                    loading: () {
                      return Container();
                    },
                  ),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/presentation/providers/play_list_provider.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_songs_provider.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_view_model.dart';
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
  int? dragHandleIndex;
  List<String> currentOrder = [];

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
    ref
        .watch(playlistSongsProvider.notifier)
        .loadSongs(widget.playlist.songIds);
  }

  @override
  Widget build(BuildContext context) {
    var songListAsync = ref.watch(playlistSongsProvider);
    listNameController.text = widget.playlist.listName;
    descriptionController.text = widget.playlist.description;
    FocusNode titleFocus = FocusNode();
    FocusNode descriptionFocus = FocusNode();

    final String currentName = widget.playlist.listName;
    final String currentDescription = widget.playlist.description;
    bool isEdited = false;

    return GestureDetector(
      onTap: () {
        titleFocus.unfocus();
        descriptionFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerRight,
            // --------------------
            // 완료 버튼
            // --------------------
            child: GestureDetector(
              onTap: () async {
                // 제목을 수정한 경우
                if (listNameController.text != currentName) {
                  await ref
                      .watch(playListsUsecaseProvider)
                      .editListName(currentName, listNameController.text);
                  isEdited = true;
                }
                // 플레이리스트 설명을 수정한 경우
                if (descriptionController.text != currentDescription) {
                  await ref.watch(playListsUsecaseProvider).editDescription(
                      currentDescription, descriptionController.text);
                  isEdited = true;
                }
                // 음악을 삭제하지 않고 플레이리스트 순서를 바꾼 경우
                if (widget.playlist.songIds.length == currentOrder.length) {
                  for (int i = 0; i < currentOrder.length; i++) {
                    if (widget.playlist.songIds[i] != currentOrder[i]) {
                      await ref.watch(playListsUsecaseProvider).editSongOrder(
                          widget.playlist.listName, currentOrder);
                      isEdited = true;
                      break;
                    }
                  }
                }
                // 수정한 요소가 있다면 플레이리스트 리로드
                if (isEdited) {
                  ref.read(playListViewModelProvider.notifier).getPlayLists();
                }
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
                                    image:
                                        NetworkImage(widget.playlist.imgUrl!)),
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
                          focusNode: titleFocus,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: widget.playlist.listName,
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
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
                            focusNode: descriptionFocus,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Image.asset(
                                    'assets/images/no_songs_in_playlist.png'),
                              ),
                            ],
                          );
                        }
                        return SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: ReorderableListView(
                            children: <Widget>[
                              for (int index = 0; index < data.length; index++)
                                ListTile(
                                  key: Key('$index'),
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: 0),
                                  contentPadding: EdgeInsets.zero,
                                  leading: ReorderableDragStartListener(
                                    index: index,
                                    child: Container(
                                        width: 44,
                                        height: 44,
                                        color: Colors.transparent,
                                        child: Icon(Icons.drag_handle)),
                                  ),
                                  tileColor: index == dragHandleIndex
                                      ? Colors.black.withValues(alpha: 0.04)
                                      : Colors.white,
                                  title: Container(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: AppColors.border,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // ---------
                                              // 곡 이미지
                                              // ---------
                                              Container(
                                                width: 48,
                                                height: 48,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: AppColors.gray600,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        data[index].imgUrl),
                                                  ),
                                                ),
                                              ),
                                              // -------
                                              // 곡 내용
                                              // -------
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 18),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data[index].title,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        data[index].artist,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color:
                                                              AppColors.gray600,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                ),
                            ],
                            onReorderStart: (index) {
                              setState(() {
                                dragHandleIndex = index;
                              });
                            },
                            onReorderEnd: (index) {
                              setState(() {
                                dragHandleIndex = null;
                              });
                            },
                            onReorder: (int oldIndex, int newIndex) {
                              setState(() {
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                data.insert(newIndex, data.removeAt(oldIndex));
                                currentOrder.clear();
                                for (var item in data) {
                                  currentOrder.add(item.video.id);
                                }
                              });
                            },
                          ),
                        );
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
      ),
    );
  }
}

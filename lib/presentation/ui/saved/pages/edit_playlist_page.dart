import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/presentation/providers/play_list_provider.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/view_models/list_sort_viewmodel.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_songs_provider.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_view_model.dart';
import 'package:oz_player/presentation/ui/saved/widgets/delete_alert_dialog.dart';
import 'package:oz_player/presentation/view_model/user_view_model.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';
import 'package:oz_player/presentation/widgets/home_tap/bottom_navigation_view_model/bottom_navigation_view_model.dart';

class EditPlaylistPage extends ConsumerStatefulWidget {
  final PlayListEntity playlist;

  const EditPlaylistPage({super.key, required this.playlist});

  @override
  ConsumerState<EditPlaylistPage> createState() => _EditPlaylistPageState();
}

class _EditPlaylistPageState extends ConsumerState<EditPlaylistPage> {
  final listNameController = TextEditingController(); // 플레이리스트 제목 컨트롤러
  final descriptionController = TextEditingController(); // 플레이리스트 설명 컨트롤러
  int? dragHandleIndex; // 현재 드래그중인 인덱스
  List<String> currentOrder = []; // 플레이리스트 순서가 바뀔 때마다 저장
  List<String> initialOrder = [];
  String? initialImageUrl;
  bool isEdited = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref
          .watch(playlistSongsProvider.notifier)
          .loadSongs(widget.playlist.songIds);
      initialImageUrl = widget.playlist.imgUrl;
    });
    listNameController.text = widget.playlist.listName;
    descriptionController.text = widget.playlist.description;
    initialOrder =
        widget.playlist.songIds.sublist(0, widget.playlist.songIds.length);
  }

  @override
  void dispose() {
    listNameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // 곡을 삭제할 때 songId를 삭제한 뒤 플레이리스트 화면 reload 하는 함수
  void removeSongId(String songId, String? newUrl) {
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

    FocusNode titleFocus = FocusNode();
    FocusNode descriptionFocus = FocusNode();

    final String currentName = widget.playlist.listName;
    final String currentDescription = widget.playlist.description;
    return GestureDetector(
      onTap: () {
        titleFocus.unfocus();
        descriptionFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          // ------------------------
          // 뒤로가기 버튼
          // ------------------------
          leading: Semantics(
            label: '뒤로 가기',
            button: true,
            child: IconButton(
              onPressed: () async {
                await ref.read(playListsUsecaseProvider).editImage(
                    ref.read(userViewModelProvider.notifier).getUserId(),
                    widget.playlist.imgUrl,
                    initialImageUrl,
                    widget.playlist.listName);
                if (isEdited) {
                  if (context.mounted) {
                    showDialog(
                      context: context,
                      builder: (context) => CancleEditAlertDialog(
                        destination: null,
                        newEntity: widget.playlist,
                        initialList: widget.playlist.songIds,
                      ),
                    );
                  }
                } else {
                  ref.read(bottomNavigationProvider.notifier).updatePage(0);
                  if (context.mounted) {
                    context.pop(
                      PlayListEntity(
                          listName: widget.playlist.listName,
                          createdAt: widget.playlist.createdAt,
                          imgUrl: initialImageUrl,
                          description: widget.playlist.description,
                          songIds: widget.playlist.songIds),
                    );
                  }
                }
              },
              icon: Icon(
                Icons.arrow_back,
                semanticLabel: '',
              ),
              color: Colors.grey[900],
            ),
          ),
          actions: [],
          title: Align(
            alignment: Alignment.centerRight,
            // --------------------
            // 저장 버튼
            // --------------------
            child: Semantics(
              button: true,
              child: GestureDetector(
                onTap: () async {
                  // 제목은 비워둘 수 없게 설정
                  if (listNameController.text == '') {
                    listNameController.text = widget.playlist.listName;
                  }
                  // 제목을 수정한 경우
                  if (listNameController.text != currentName) {
                    await ref.watch(playListsUsecaseProvider).editListName(
                        ref.read(userViewModelProvider.notifier).getUserId(),
                        currentName,
                        listNameController.text);
                    isEdited = true;
                  }
                  // 플레이리스트 설명을 수정한 경우
                  if (descriptionController.text != currentDescription) {
                    await ref.watch(playListsUsecaseProvider).editDescription(
                        ref.read(userViewModelProvider.notifier).getUserId(),
                        currentDescription,
                        descriptionController.text);
                    isEdited = true;
                  }
                  // 음악을 삭제하지 않고 플레이리스트 순서를 바꾼 경우
                  if (widget.playlist.songIds.length == currentOrder.length) {
                    for (int i = 0; i < currentOrder.length; i++) {
                      if (widget.playlist.songIds[i] != currentOrder[i]) {
                        await ref.watch(playListsUsecaseProvider).editSongOrder(
                            ref
                                .read(userViewModelProvider.notifier)
                                .getUserId(),
                            widget.playlist.listName,
                            currentOrder);
                        isEdited = true;
                        break;
                      }
                    }
                  }
                  // 이미지 변경
                  await ref.read(playListsUsecaseProvider).editImage(
                      ref.read(userViewModelProvider.notifier).getUserId(),
                      widget.playlist.imgUrl,
                      initialImageUrl,
                      widget.playlist.listName);

                  // 수정한 요소가 있다면 플레이리스트 리로드
                  if (isEdited) {
                    await ref
                        .read(playListViewModelProvider.notifier)
                        .getPlayLists();
                    if (ref.watch(listSortViewModelProvider) ==
                        SortedType.latest) {
                      ref.read(listSortViewModelProvider.notifier).setLatest();
                    } else {
                      ref
                          .read(listSortViewModelProvider.notifier)
                          .setAscending();
                    }
                  }

                  if (context.mounted) {
                    context.pop(
                      PlayListEntity(
                        listName: listNameController.text,
                        createdAt: widget.playlist.createdAt,
                        imgUrl: initialImageUrl,
                        description: descriptionController.text,
                        songIds: currentOrder.isEmpty
                            ? widget.playlist.songIds
                            : currentOrder,
                      ),
                    );
                    ref.watch(bottomNavigationProvider.notifier).updatePage(0);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 44,
                  height: 44,
                  color: Colors.transparent,
                  child: Text(
                    '저장',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            // 상단 요소 : 이미지, 제목, 메모
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -------------------
                // 플레이리스트 대표 이미지
                // -------------------
                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                  child: Column(
                    children: [
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
                                        image: AssetImage(
                                            'assets/images/empty_thumbnail.png'))
                                    : DecorationImage(
                                        image: NetworkImage(
                                            widget.playlist.imgUrl!)),
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
                            color: AppColors.border,
                            width: 1,
                          )),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ---------------
                            // 플레이리스트 제목
                            // ---------------
                            Semantics(
                              label: '제목 편집',
                              child: TextField(
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
                                    color: AppColors.gray400,
                                  ),
                                ),
                                onChanged: (value) => isEdited = true,
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
                              child: Semantics(
                                label: '설명 편집',
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
                                    hintText: '플레이리스트 설명을 입력하세요',
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: AppColors.gray400,
                                    ),
                                  ),
                                  onChanged: (value) => isEdited = true,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                // ---------------
                // 음악 목록
                // ---------------
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: songListAsync.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                      'assets/svg/no_songs_in_playlist.svg'),
                                  const SizedBox(
                                    height: 250,
                                  ),
                                ],
                              ),
                            );
                          }
                          return SizedBox(
                            width: double.infinity,
                            height: 300,
                            // ------------------------------
                            // 순서 재배치 가능한 리스트
                            // ------------------------------
                            child: ReorderableListView(
                              children: <Widget>[
                                for (int index = 0;
                                    index < data.length;
                                    index++)
                                  ListTile(
                                    key: Key('$index'),
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: 4),
                                    contentPadding: EdgeInsets.zero,
                                    minVerticalPadding: 0,
                                    minTileHeight: 72,
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
                                    // -----------------------------
                                    // 슬라이더 위젯
                                    // -----------------------------
                                    title: Semantics(
                                      hint: '오른쪽으로 슬라이드하여 삭제',
                                      child: Slidable(
                                        key: const ValueKey(0),
                                        endActionPane: ActionPane(
                                          extentRatio: 0.25,
                                          motion: BehindMotion(),
                                          children: [
                                            // ------------------------
                                            // 삭제 버튼 클릭 시 액션
                                            // ------------------------
                                            SlidableAction(
                                              flex: 1,
                                              onPressed: (value) {
                                                String id =
                                                    data[index].video.id;
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      if (index != 0) {
                                                        // 리스트의 첫 번째가 아닌 곡 삭제
                                                        return DeleteSongAlertDialog(
                                                          listName: widget
                                                              .playlist
                                                              .listName,
                                                          songId: id,
                                                          removeSongId: () =>
                                                              removeSongId(
                                                                  id,
                                                                  widget
                                                                      .playlist
                                                                      .imgUrl),
                                                        );
                                                      } else if (data.length >
                                                          1) {
                                                        // 리스트의 첫 번째 곡 삭제 && 리스트 길이 2이상
                                                        initialImageUrl =
                                                            data[index + 1]
                                                                .imgUrl;
                                                        return DeleteSongAlertDialog(
                                                          listName: widget
                                                              .playlist
                                                              .listName,
                                                          songId: data[index]
                                                              .video
                                                              .id,
                                                          removeSongId: () =>
                                                              removeSongId(
                                                                  data[index]
                                                                      .video
                                                                      .id,
                                                                  data[index +
                                                                          1]
                                                                      .imgUrl),
                                                          prevUrl: data[index]
                                                              .imgUrl,
                                                          newUrl:
                                                              data[index + 1]
                                                                  .imgUrl,
                                                        );
                                                      } else {
                                                        // 리스트의 첫 번째 곡 삭제 && 리스트 길이 1이하
                                                        initialImageUrl = null;
                                                        return DeleteSongAlertDialog(
                                                          listName: widget
                                                              .playlist
                                                              .listName,
                                                          songId: data[index]
                                                              .video
                                                              .id,
                                                          removeSongId: () =>
                                                              removeSongId(
                                                                  data[index]
                                                                      .video
                                                                      .id,
                                                                  null),
                                                          prevUrl: data[index]
                                                              .imgUrl,
                                                          newUrl: null,
                                                        );
                                                      }
                                                    });
                                              },
                                              backgroundColor: AppColors.red,
                                              foregroundColor: Colors.white,
                                              label: '삭제',
                                            ),
                                          ],
                                        ),
                                        // 리스트 블록 레이아웃
                                        child: SizedBox(
                                          height: 72,
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
                                                            BorderRadius
                                                                .circular(4),
                                                        color:
                                                            AppColors.gray600,
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              data[index]
                                                                  .imgUrl),
                                                        ),
                                                      ),
                                                    ),
                                                    // -------
                                                    // 곡 내용
                                                    // -------
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
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
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            Text(
                                                              data[index]
                                                                  .artist,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .gray600,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                              Container(
                                                width: 60,
                                                height: 60,
                                                color: Colors.transparent,
                                                child: Icon(Icons.more_vert),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                Container(
                                  key: Key('empty item'),
                                  height: 90,
                                  color: Colors.transparent,
                                )
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
                                  data.insert(
                                      newIndex, data.removeAt(oldIndex));
                                  currentOrder.clear();
                                  // 변경한 순서 저장
                                  for (var item in data) {
                                    currentOrder.add(item.video.id);
                                  }
                                  // 저장한 곡이 0개이면 대표 이미지 url을 null로
                                  if (data.isEmpty) {
                                    initialImageUrl = null;
                                    // 저장한 곡이 하나라도 있으면 대표 이미지 url을 1번 곡의 이미지 url로 설정
                                  } else {
                                    initialImageUrl = data[0].imgUrl;
                                  }
                                });
                                isEdited = true;
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
                  ),
                ),
              ],
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 24,
                child: AudioPlayer(
                  colorMode: true,
                ))
          ],
        ),
      ),
    );
  }
}

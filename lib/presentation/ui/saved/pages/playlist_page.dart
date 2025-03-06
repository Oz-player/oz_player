import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/recommend_page/widgets/save_playlist_bottom_sheet.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_songs_provider.dart';
import 'package:oz_player/presentation/ui/saved/widgets/delete_alert_dialog.dart';
import 'package:oz_player/presentation/ui/saved/widgets/menu_bottom_sheets.dart';
import 'package:oz_player/presentation/ui/saved/widgets/play_buttons.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_bottomsheet.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';
import 'package:oz_player/presentation/widgets/home_tap/bottom_navigation_view_model/bottom_navigation_view_model.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';
import 'package:oz_player/presentation/widgets/loading/loading_view_model/loading_view_model.dart';
import 'package:oz_player/presentation/widgets/loading/loading_widget.dart';

class PlaylistPage extends ConsumerStatefulWidget {
  final PlayListEntity playlist;

  const PlaylistPage({super.key, required this.playlist});

  @override
  ConsumerState<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends ConsumerState<PlaylistPage> {
  PlayListEntity? playlist;

  @override
  void initState() {
    super.initState();
    playlist = widget.playlist;
    Future.microtask(() async {
      await ref
          .read(playlistSongsProvider.notifier)
          .loadSongs(widget.playlist.songIds);
    });
  }

  // 곡을 삭제할 때 songId를 삭제한 뒤 플레이리스트 화면 reload 하는 함수
  void removeSongId(String songId, String? newUrl) async {
    setState(() {
      widget.playlist.songIds.remove(songId);
      playlist = PlayListEntity(
          listName: widget.playlist.listName,
          createdAt: widget.playlist.createdAt,
          imgUrl: newUrl,
          description: widget.playlist.description,
          songIds: widget.playlist.songIds);
    });
    await ref
        .read(playlistSongsProvider.notifier)
        .loadSongs(widget.playlist.songIds);
  }

  // AudioPlayer에 리스트를 넣어서 재생하는 기능
  Future<void> addListInAudioPlayer(List<SongEntity> data) async {
    if (data.isEmpty) {
      return;
    }

    final nextSong = List<SongEntity>.from(data)..removeAt(0);

    ref.read(audioPlayerViewModelProvider.notifier).isStartLoadingAudioPlayer();
    AudioBottomSheet.showCurrentAudio(context);
    ref.read(audioPlayerViewModelProvider.notifier).setCurrentSong(data.first);
    ref.read(audioPlayerViewModelProvider.notifier).setNextSongList(nextSong);
    await ref
        .read(audioPlayerViewModelProvider.notifier)
        .setAudioPlayer(data.first.video.audioUrl, -2);
  }

  // 플레이리스트 리로드
  void setListState(PlayListEntity newList) async {
    setState(() {
      playlist = newList;
    });
    ref.watch(playlistSongsProvider.notifier).loadSongs(newList.songIds);
  }

  @override
  Widget build(BuildContext context) {
    // 플레이리스트의 음악 목록 Async
    var songListAsync = ref.watch(playlistSongsProvider);
    final loadingState = ref.watch(loadingViewModelProvider);

    return loadingState.isLoading
        ? Stack(
            children: [
              MainScaffold(
                widget: widget,
                songListAsync: songListAsync,
                ref: ref,
                removeSongId: removeSongId,
                addListInAudioPlayer: addListInAudioPlayer,
                scaffoldPlaylist: playlist!,
                setListState: setListState,
              ),
              LoadingWidget(),
            ],
          )
        : MainScaffold(
            widget: widget,
            songListAsync: songListAsync,
            ref: ref,
            removeSongId: removeSongId,
            addListInAudioPlayer: addListInAudioPlayer,
            scaffoldPlaylist: playlist!,
            setListState: setListState,
          );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({
    super.key,
    required this.scaffoldPlaylist,
    required this.widget,
    required this.songListAsync,
    required this.ref,
    required this.removeSongId,
    required this.addListInAudioPlayer,
    required this.setListState,
  });

  final void Function(String songId, String? newUrl) removeSongId;
  final void Function(List<SongEntity> data) addListInAudioPlayer;
  final void Function(PlayListEntity newList) setListState;
  final PlaylistPage widget;
  final PlayListEntity scaffoldPlaylist;
  final AsyncValue<List<SongEntity>> songListAsync;
  final WidgetRef ref;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  bool isOverlayOn = false;

  void setOverlayOn() {
    setState(() {
      isOverlayOn = !isOverlayOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '',
      child: GestureDetector(
        onTap: () => setState(() {
          isOverlayOn = false;
        }),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
            title: Text(
              '플레이리스트',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            leading: Semantics(
              button: true,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  semanticLabel: '보관함으로 돌아가기',
                ),
                color: Colors.grey[900],
              ),
            ),
            actions: [
              Semantics(
                label: '설정 버튼',
                button: true,
                child: IconButton(
                    onPressed: () {
                      context.push('/settings');
                    },
                    icon: SvgPicture.asset(
                      'assets/svg/option_icon.svg',
                      semanticsLabel: '',
                    )),
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ------------------------------------------------------
                    // 플레이리스트 대표 이미지
                    // ------------------------------------------------------
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
                              image: widget.scaffoldPlaylist.imgUrl == null
                                  ? DecorationImage(
                                      image: AssetImage(
                                          'assets/images/empty_thumbnail.png'))
                                  : DecorationImage(
                                      image: NetworkImage(
                                          widget.scaffoldPlaylist.imgUrl!)),
                            ),
                          ),
                          // ----------------------------------------------------------
                          // 플레이리스트 관리 메뉴 버튼
                          // ----------------------------------------------------------
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => SavedMenuBottomSheet(
                                  imgUrl: widget.scaffoldPlaylist.imgUrl,
                                  name: widget.scaffoldPlaylist.listName,
                                  items: [
                                    // --------------------------------
                                    // playlist menu : 1. 셔플 재생
                                    // --------------------------------
                                    GestureDetector(
                                      onTap: () async {
                                        context.pop();
                                        await widget.ref
                                            .read(audioPlayerViewModelProvider
                                                .notifier)
                                            .toggleStop();
                                        widget.songListAsync.when(
                                          data: (data) async {
                                            List<SongEntity> list = [];
                                            for (var item in data) {
                                              list.add(item);
                                            }
                                            list.shuffle();
                                            widget.addListInAudioPlayer(list);
                                          },
                                          error: (error, stackTrace) {},
                                          loading: () {},
                                        );
                                      },
                                      child:
                                          BottomSheetMenuButton(title: '셔플 재생'),
                                    ),
                                    // --------------------------------
                                    // playlist menu : 2. 플레이리스트 편집
                                    // --------------------------------
                                    GestureDetector(
                                      onTap: () async {
                                        context.pop();
                                        widget.ref
                                            .read(bottomNavigationProvider
                                                .notifier)
                                            .updatePage(5);
                                        final newList = await context.push(
                                          '/saved/playlist/edit',
                                          extra: widget.scaffoldPlaylist,
                                        ) as PlayListEntity;
                                        widget.setListState(newList);
                                      },
                                      child: BottomSheetMenuButton(
                                        title: '플레이리스트 편집',
                                      ),
                                    ),
                                    // --------------------------------
                                    // playlist menu : 3. 플레이리스트 삭제
                                    // --------------------------------
                                    GestureDetector(
                                      onTap: () {
                                        context.pop();
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) =>
                                              DeletePlayListAlertDialog(
                                            listName: widget
                                                .scaffoldPlaylist.listName,
                                          ),
                                        );
                                      },
                                      child: BottomSheetMenuButton(
                                          title: '플레이리스트 삭제'),
                                    )
                                  ],
                                ),
                              );
                            },
                            icon: Semantics(
                              label: '플레이리스트 옵션',
                              child: Image.asset(
                                  'assets/images/menu_thin_icon.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // ------------------------------------------------------
                    // 플레이리스트 본문
                    // ------------------------------------------------------
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
                            label: '플레이리스트 제목',
                            child: Text(
                              widget.scaffoldPlaylist.listName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
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
                          Semantics(
                            child: SizedBox(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Semantics(
                                    label: '설명',
                                    child: Text(
                                      widget.scaffoldPlaylist.description,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: AppColors.gray600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // ------------------
                          // 플레이리스트 재생 버튼
                          // ------------------
                          widget.songListAsync.when(
                            data: (data) {
                              return data.isEmpty
                                  ? Container()
                                  : SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Semantics(
                                            label: '전체 재생',
                                            button: true,
                                            child: GestureDetector(
                                              onTap: () async {
                                                await widget.ref
                                                    .read(
                                                        audioPlayerViewModelProvider
                                                            .notifier)
                                                    .toggleStop();
                                                widget
                                                    .addListInAudioPlayer(data);
                                              },
                                              child: PlayButton(),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // ------------------
                                              // 플레이리스트 편집 버튼
                                              // ------------------
                                              Semantics(
                                                label: '플레이리스트 편집',
                                                button: true,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    widget.ref
                                                        .read(
                                                            bottomNavigationProvider
                                                                .notifier)
                                                        .updatePage(5);
                                                    if (context.mounted) {
                                                      final newList =
                                                          await context.push(
                                                        '/saved/playlist/edit',
                                                        extra: widget
                                                            .scaffoldPlaylist,
                                                      ) as PlayListEntity;
                                                      widget.setListState(
                                                          newList);
                                                    }
                                                  },
                                                  child: SvgPicture.asset(
                                                      'assets/svg/button_edit.svg'),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              // ---------------------
                                              // 플레이리스트 셔플 재생 버튼
                                              // ---------------------
                                              Semantics(
                                                label: '셔플 재생',
                                                button: true,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    await widget.ref
                                                        .read(
                                                            audioPlayerViewModelProvider
                                                                .notifier)
                                                        .toggleStop();

                                                    widget.songListAsync.when(
                                                      data: (data) async {
                                                        List<SongEntity> list =
                                                            [];
                                                        for (var item in data) {
                                                          list.add(item);
                                                        }
                                                        list.shuffle();
                                                        widget
                                                            .addListInAudioPlayer(
                                                                list);
                                                      },
                                                      error: (error,
                                                          stackTrace) {},
                                                      loading: () {},
                                                    );
                                                  },
                                                  child: SvgPicture.asset(
                                                      'assets/svg/button_shuffle.svg'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                            },
                            // 오류 시 회색 버튼 출력
                            error: (error, stackTrace) => Container(),
                            loading: () => Container(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // ------------------------------------------------------------------
                    // 음악 목록
                    // ------------------------------------------------------------------
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: widget.songListAsync.when(
                          data: (data) {
                            // 플레이리스트가 비었을 경우 검색 페이지로 redirecting 버튼
                            if (data.isEmpty) {
                              return Stack(
                                children: [
                                  Positioned(
                                    top: 20,
                                    left: 0,
                                    right: 0,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/svg/no_songs_in_playlist.svg',
                                                  semanticsLabel:
                                                      '플레이리스트가 비어있습니다',
                                                ),
                                                const SizedBox(
                                                  height: 50,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Semantics(
                                          label: '곡 검색하여 추가하기',
                                          button: true,
                                          child: GestureDetector(
                                            onTap: () {
                                              widget.ref
                                                  .watch(
                                                      bottomNavigationProvider
                                                          .notifier)
                                                  .updatePage(2);
                                              context.go('/search');
                                            },
                                            child: ExcludeSemantics(
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 160,
                                                height: 48,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: AppColors.gray800,
                                                ),
                                                child: Text(
                                                  '음악 추가하기',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Positioned(
                                  //   left: 60,
                                  //   right: 60,
                                  //   bottom: 114,
                                  //   child: Semantics(
                                  //     label: '곡 검색하여 추가하기',
                                  //     button: true,
                                  //     child: GestureDetector(
                                  //       onTap: () {
                                  //         widget.ref
                                  //             .watch(bottomNavigationProvider
                                  //                 .notifier)
                                  //             .updatePage(2);
                                  //         context.go('/search');
                                  //       },
                                  //       child: ExcludeSemantics(
                                  //         child: Container(
                                  //           alignment: Alignment.center,
                                  //           width: 160,
                                  //           height: 48,
                                  //           decoration: BoxDecoration(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(8),
                                  //             color: AppColors.gray800,
                                  //           ),
                                  //           child: Text(
                                  //             '음악 추가하기',
                                  //             style: TextStyle(
                                  //                 fontWeight: FontWeight.w600,
                                  //                 fontSize: 16,
                                  //                 color: Colors.white),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              );
                            }
                            return ListView.separated(
                              itemCount: data.length + 1,
                              separatorBuilder: (context, index) => Container(
                                width: double.infinity,
                                height: 1,
                                color: AppColors.border,
                              ),
                              itemBuilder: (context, index) {
                                return index >= data.length
                                    ? SizedBox(
                                        height: 90,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 30),
                                          child: SvgPicture.asset(
                                              'assets/svg/list_trailer.svg'),
                                        ),
                                      )
                                    : Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        width: double.infinity,
                                        height: 72,
                                        color: Colors.transparent,
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
                                                          BorderRadius.circular(
                                                              4),
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
                                                          Semantics(
                                                            label: '제목',
                                                            child: Text(
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
                                                          ),
                                                          Semantics(
                                                            label: '가수',
                                                            child: Text(
                                                              data[index]
                                                                  .artist,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .gray600,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // ---------------
                                            // 음악 세부 메뉴 버튼
                                            // ---------------
                                            IconButton(
                                              onPressed: () {
                                                showModalBottomSheet<void>(
                                                  context: context,
                                                  builder: (context) =>
                                                      SavedMenuBottomSheet(
                                                    imgUrl: data[index].imgUrl,
                                                    name: data[index].title,
                                                    items: [
                                                      // --------------------------------
                                                      // song menu : 1. 음악 재생
                                                      // --------------------------------
                                                      GestureDetector(
                                                        onTap: () async {
                                                          context.pop();
                                                          await widget.ref
                                                              .read(
                                                                  audioPlayerViewModelProvider
                                                                      .notifier)
                                                              .toggleStop();

                                                          widget
                                                              .addListInAudioPlayer(
                                                                  [data[index]]);
                                                        },
                                                        child:
                                                            BottomSheetMenuButton(
                                                                title: '재생'),
                                                      ),
                                                      // --------------------------------
                                                      // song menu : 2. 다른 리스트에 저장
                                                      // --------------------------------
                                                      GestureDetector(
                                                        onTap: () {
                                                          context.pop();
                                                          TextEditingController
                                                              titleController =
                                                              TextEditingController();
                                                          TextEditingController
                                                              descriptionController =
                                                              TextEditingController();
                                                          SavePlaylistBottomSheet
                                                              .show(
                                                            context,
                                                            widget.ref,
                                                            titleController,
                                                            descriptionController,
                                                            data[index],
                                                          );
                                                        },
                                                        child:
                                                            BottomSheetMenuButton(
                                                          title: '플레이리스트에 저장',
                                                        ),
                                                      ),
                                                      // --------------------------------
                                                      // song menu : 3. 음악 삭제
                                                      // --------------------------------
                                                      GestureDetector(
                                                        onTap: () {
                                                          context.pop();
                                                          showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                false,
                                                            builder: (context) => index ==
                                                                    0
                                                                ? data.length >
                                                                        1
                                                                    // 리스트의 첫 번째 곡 삭제 && 리스트 길이 2이상
                                                                    ? DeleteSongAlertDialog(
                                                                        listName: widget
                                                                            .scaffoldPlaylist
                                                                            .listName,
                                                                        songId: data[index]
                                                                            .video
                                                                            .id,
                                                                        removeSongId: () => widget.removeSongId(
                                                                            data[index].video.id,
                                                                            data[index + 1].imgUrl),
                                                                        prevUrl:
                                                                            data[index].imgUrl,
                                                                        newUrl: data[index +
                                                                                1]
                                                                            .imgUrl,
                                                                      )
                                                                    // 리스트의 첫 번째 곡 삭제 && 리스트 길이 1이하
                                                                    : DeleteSongAlertDialog(
                                                                        listName: widget
                                                                            .scaffoldPlaylist
                                                                            .listName,
                                                                        songId: data[index]
                                                                            .video
                                                                            .id,
                                                                        removeSongId: () => widget.removeSongId(
                                                                            data[index].video.id,
                                                                            null),
                                                                        prevUrl:
                                                                            data[index].imgUrl,
                                                                        newUrl:
                                                                            null,
                                                                      )
                                                                // 리스트의 첫 번째가 아닌 곡 삭제
                                                                : DeleteSongAlertDialog(
                                                                    removeSongId: () => widget.removeSongId(
                                                                        data[index]
                                                                            .video
                                                                            .id,
                                                                        widget
                                                                            .scaffoldPlaylist
                                                                            .imgUrl),
                                                                    listName: widget
                                                                        .scaffoldPlaylist
                                                                        .listName,
                                                                    songId: data[
                                                                            index]
                                                                        .video
                                                                        .id,
                                                                  ),
                                                          );
                                                        },
                                                        child:
                                                            BottomSheetMenuButton(
                                                                title: '음악 삭제'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              icon: Semantics(
                                                label: '음악 옵션',
                                                child: Image.asset(
                                                    'assets/images/menu_thin_icon.png'),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                              },
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
        ),
      ),
    );
  }
}

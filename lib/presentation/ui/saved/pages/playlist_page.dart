import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/recommend_page/widgets/save_playlist_bottom_sheet.dart';
import 'package:oz_player/presentation/ui/saved/view_models/list_sort_viewmodel.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_songs_provider.dart';
import 'package:oz_player/presentation/ui/saved/widgets/delete_alert_dialog.dart';
import 'package:oz_player/presentation/ui/saved/widgets/menu_bottom_sheets.dart';
import 'package:oz_player/presentation/ui/saved/widgets/play_buttons.dart';
import 'package:oz_player/presentation/ui/saved/widgets/sorted_type_box.dart';
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
          .watch(playlistSongsProvider.notifier)
          .loadSongs(widget.playlist.songIds);
    });
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
                playlist: playlist!,
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
            playlist: playlist!,
            setListState: setListState,
          );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({
    super.key,
    required this.playlist,
    required this.widget,
    required this.songListAsync,
    required this.ref,
    required this.removeSongId,
    required this.addListInAudioPlayer,
    required this.setListState,
  });

  final void Function(String songId) removeSongId;
  final void Function(List<SongEntity> data) addListInAudioPlayer;
  final void Function(PlayListEntity newList) setListState;
  final PlaylistPage widget;
  final PlayListEntity playlist;
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
    final viewModel = widget.ref.watch(listSortViewModelProvider.notifier);

    return GestureDetector(
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
          actions: [
            IconButton(
                onPressed: () {
                  context.push('/settings');
                },
                icon: Image.asset('assets/images/option_icon.png')),
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
                            image: widget.playlist.imgUrl == null
                                ? DecorationImage(
                                    image: AssetImage('assets/images/muoz.png'))
                                : DecorationImage(
                                    image:
                                        NetworkImage(widget.playlist.imgUrl!)),
                          ),
                        ),
                        // ----------------------------------------------------------
                        // 플레이리스트 관리 메뉴 버튼
                        // ----------------------------------------------------------
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (context) => SavedMenuBottomSheet(
                                imgUrl: widget.playlist.imgUrl,
                                name: widget.playlist.listName,
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
                                          .read(
                                              bottomNavigationProvider.notifier)
                                          .updatePage(5);
                                      final newList = await context.push(
                                        '/saved/playlist/edit',
                                        extra: widget.playlist,
                                      ) as PlayListEntity;
                                      widget.setListState(newList);
                                      widget.ref
                                          .read(listSortViewModelProvider
                                              .notifier)
                                          .setLatest();
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
                                          listName: widget.playlist.listName,
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
                          child: Container(
                            width: 44,
                            height: 44,
                            color: Colors.transparent,
                            child:
                                Image.asset('assets/images/menu_bold_icon.png'),
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
                        Text(
                          widget.playlist.listName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // ---------------
                        // 플레이리스트 설명
                        // ---------------
                        SizedBox(
                          width: 335,
                          height: 40,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.playlist.description,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: AppColors.gray600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ------------------
                            // 플레이리스트 재생 버튼
                            // ------------------
                            widget.songListAsync.when(
                              data: (data) {
                                return GestureDetector(
                                  onTap: () async {
                                    await widget.ref
                                        .read(audioPlayerViewModelProvider
                                            .notifier)
                                        .toggleStop();
                                    widget.addListInAudioPlayer(data);
                                  },
                                  child: PlayButton(),
                                );
                              },
                              // 오류 시 회색 버튼 출력
                              error: (error, stackTrace) =>
                                  PlayButtonDisabled(),
                              loading: () => PlayButtonDisabled(),
                            ),
                            Row(
                              children: [
                                // ------------------
                                // 플레이리스트 편집 버튼
                                // ------------------
                                GestureDetector(
                                  onTap: () async {
                                    await widget.ref
                                        .read(audioPlayerViewModelProvider
                                            .notifier)
                                        .toggleStop();
                                    widget.ref
                                        .read(bottomNavigationProvider.notifier)
                                        .updatePage(5);
                                    if (context.mounted) {
                                      final newList = await context.push(
                                        '/saved/playlist/edit',
                                        extra: widget.playlist,
                                      ) as PlayListEntity;
                                      widget.setListState(newList);
                                      widget.ref
                                          .read(listSortViewModelProvider
                                              .notifier)
                                          .setLatest();
                                    }
                                  },
                                  child: Image.asset(
                                      'assets/images/button_edit.png'),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                // ---------------------
                                // 플레이리스트 셔플 재생 버튼
                                // ---------------------
                                GestureDetector(
                                  onTap: () async {
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
                                  child: Image.asset(
                                      'assets/images/button_shuffle.png'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  // ------------------------------------------------------------------
                  // 정렬 방법 선택창
                  // ------------------------------------------------------------------
                  SortedTypeBox(
                      ref: widget.ref,
                      isOverlayOn: isOverlayOn,
                      setOverlayOn: setOverlayOn),
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
                                  child: Image.asset(
                                      'assets/images/no_songs_in_playlist.png'),
                                ),
                                Positioned(
                                  left: 60,
                                  right: 60,
                                  bottom: 32,
                                  child: GestureDetector(
                                    onTap: () {
                                      widget.ref
                                          .watch(
                                              bottomNavigationProvider.notifier)
                                          .updatePage(2);
                                      context.go('/search');
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 160,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.gray800,
                                      ),
                                      child: Text(
                                        '음악 추가하기',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
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
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 30),
                                        child: SvgPicture.asset(
                                            'assets/svg/muoz.svg'),
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
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .gray600,
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
                                          // ---------------
                                          // 음악 세부 메뉴 버튼
                                          // ---------------
                                          GestureDetector(
                                            onTap: () {
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
                                                            builder: (context) =>
                                                                DeleteSongAlertDialog(
                                                                  removeSongId: () =>
                                                                      widget.removeSongId(data[
                                                                              index]
                                                                          .video
                                                                          .id),
                                                                  listName: widget
                                                                      .widget
                                                                      .playlist
                                                                      .listName,
                                                                  songId: data[
                                                                          index]
                                                                      .video
                                                                      .id,
                                                                ));
                                                      },
                                                      child:
                                                          BottomSheetMenuButton(
                                                              title: '음악 삭제'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 44,
                                              height: 44,
                                              color: Colors.transparent,
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
            // ------------------------------------------------
            // 정렬 방법 변경용 오버레이
            // ------------------------------------------------
            SortedTypeOverlay(
              isOverlayOn: isOverlayOn,
              widget: widget,
              whenLatest: () {
                viewModel.setSongsLatest(widget.playlist.songIds);
                setState(() {
                  isOverlayOn = false;
                });
              },
              whenAscending: () {
                viewModel.setSongsAscending(widget.playlist.songIds);
                setState(() {
                  isOverlayOn = false;
                });
              },
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
      ),
    );
  }
}

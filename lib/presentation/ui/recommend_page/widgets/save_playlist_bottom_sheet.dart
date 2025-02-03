import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/data/dto/play_list_dto.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/presentation/providers/play_list_provider.dart';
import 'package:oz_player/presentation/providers/raw_song_provider.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/card_position_provider.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/condition_view_model.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/save_playlist_bottom_sheet.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_view_model.dart';
import 'package:oz_player/presentation/widgets/loading/loading_view_model/loading_view_model.dart';

class SavePlaylistBottomSheet {
  static void show(BuildContext context, WidgetRef ref,
      TextEditingController title, TextEditingController description) async {
    final openSheet = await showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: true,
        isScrollControlled: true,
        builder: (context) {
          return Consumer(
            builder: (context, ref, child) {
              final playListAsync = ref.watch(playListViewModelProvider);
              final playListState = ref.watch(savePlaylistBottomSheetProvider);
              final loading = ref.watch(loadingViewModelProvider).isLoading;
              final songEntity = ref
                  .watch(conditionViewModelProvider)
                  .recommendSongs[ref.watch(cardPositionProvider)];

              return playListAsync.when(
                error: (error, stackTrace) => Container(),
                loading: () => Container(),
                data: (data) {
                  String playlistTitle;

                  if (data.isEmpty) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24)),
                      ),
                      child: Wrap(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                                width: double.maxFinite,
                              ),
                              Container(
                                height: 5,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[400],
                                ),
                              ),
                              SizedBox(
                                height: 28,
                              ),
                              Text(
                                '이 음악을 나의\n플레이리스트에 추가',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 28,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.grey[800]),
                                      ),
                                      onPressed: () {
                                        if (ref
                                            .watch(loadingViewModelProvider)
                                            .isLoading) {
                                          return;
                                        }

                                        context.pop();
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) =>
                                                playlistDialog(
                                                    title, description));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Row(
                                          children: [
                                            Text(
                                              '새로 만들기',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Icon(
                                              Icons.add,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                child: Image.asset(
                                    'assets/images/playlist_empty.png'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 20),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  height: 48,
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                          disabledForegroundColor:
                                              Colors.grey[400],
                                          disabledBackgroundColor:
                                              Colors.grey[300],
                                          backgroundColor:
                                              playListState.isClickedPlayList ==
                                                      -1
                                                  ? Colors.grey[300]
                                                  : Colors.grey[800],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      onPressed: () async {},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: Text(
                                          '플레이리스트에 음악카드 추가하기',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  if (playListState.blind) {
                    return SizedBox.shrink();
                  }
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                    ),
                    child: Wrap(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: double.maxFinite,
                                ),
                                Container(
                                  height: 5,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[400],
                                  ),
                                ),
                                SizedBox(
                                  height: 28,
                                ),
                                Text(
                                  '이 음악을 나의\n플레이리스트에 추가',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 28,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.grey[800]),
                                        ),
                                        onPressed: () {
                                          if (ref
                                              .watch(loadingViewModelProvider)
                                              .isLoading) {
                                            return;
                                          }

                                          context.pop();
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) =>
                                                  playlistDialog(
                                                      title, description));
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Row(
                                            children: [
                                              Text(
                                                '새로 만들기',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Icon(
                                                Icons.add,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: data.length * 80.0 > 400
                                      ? 400
                                      : data.length * 80.0,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      height: 0,
                                      color:
                                          Colors.black.withValues(alpha: 0.1),
                                    ),
                                    itemCount: data.length,
                                    itemBuilder: (context, index) => Container(
                                      decoration: BoxDecoration(
                                        color:
                                            playListState.isClickedPlayList ==
                                                    index
                                                ? Colors.black
                                                    .withValues(alpha: 0.1)
                                                : Colors.white,
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      height: 80,
                                      child: InkWell(
                                        onTap: () {
                                          ref
                                              .read(
                                                  savePlaylistBottomSheetProvider
                                                      .notifier)
                                              .isClickedPlayList(index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    // 플레이리스트 대표 이미지
                                                    Container(
                                                      width: 56,
                                                      height: 56,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        image: data[index]
                                                                    .imgUrl ==
                                                                null
                                                            ? DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/images/muoz.png'),
                                                                fit: BoxFit
                                                                    .contain)
                                                            : DecorationImage(
                                                                image: NetworkImage(
                                                                    data[index]
                                                                        .imgUrl!),
                                                              ),
                                                      ),
                                                    ),
                                                    // 플레이리스트 내용
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
                                                              data[index]
                                                                  .listName,
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
                                                              '${data[index].songIds.length}개의 곡',
                                                              style: TextStyle(
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 20),
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    height: 48,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            disabledForegroundColor:
                                                Colors.grey[400],
                                            disabledBackgroundColor:
                                                Colors.grey[300],
                                            backgroundColor: playListState
                                                        .isClickedPlayList ==
                                                    -1
                                                ? Colors.grey[300]
                                                : Colors.grey[800],
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        onPressed: () async {
                                          if (playListState.isClickedPlayList ==
                                              -1) {
                                            return;
                                          }

                                          if (loading) {
                                            return;
                                          }

                                          playlistTitle = data[playListState
                                                  .isClickedPlayList!]
                                              .listName;

                                          ref
                                              .read(loadingViewModelProvider
                                                  .notifier)
                                              .startLoading(4);

                                          ref
                                              .read(
                                                  savePlaylistBottomSheetProvider
                                                      .notifier)
                                              .isBlind();

                                          final entity = RawSongEntity(
                                              countLibrary: 0,
                                              countPlaylist: 0,
                                              video: songEntity.video,
                                              title: songEntity.title,
                                              imgUrl: songEntity.imgUrl,
                                              artist: songEntity.artist);

                                          // 플레이리스트에 곡 추가 로직
                                          await ref
                                              .read(rawSongUsecaseProvider)
                                              .updateRawSongByPlaylist(entity);

                                          await ref
                                              .read(playListsUsecaseProvider)
                                              .addSong(playlistTitle, entity);

                                          await ref
                                              .read(playListViewModelProvider
                                                  .notifier)
                                              .getPlayLists();

                                          if (context.mounted) {
                                            context.pop();
                                            ref
                                                .read(
                                                    savePlaylistBottomSheetProvider
                                                        .notifier)
                                                .reflash();
                                            ref
                                                .read(loadingViewModelProvider
                                                    .notifier)
                                                .endLoading();
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Text(
                                            '플레이리스트에 음악카드 추가하기',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        });

    /// 드래그로 닫을 경우 호출됨
    if (openSheet == null) {
      await Future.delayed(Duration(milliseconds: 500));
    }
  }
}

Widget playlistDialog(
    TextEditingController title, TextEditingController description) {
  return Consumer(
    builder: (context, ref, child) {
      final loading = ref.watch(loadingViewModelProvider).isLoading;
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: loading
            ? SizedBox.shrink()
            : AlertDialog(
                backgroundColor: Colors.white,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 28,
                    ),
                    Text(
                      '새로운 플레이리스트를\n생성합니다',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 260,
                      child: TextField(
                        controller: title,
                        style: TextStyle(
                          color: Colors.grey[900],
                        ),
                        maxLines: 1,
                        maxLength: 20,
                        buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                required maxLength}) =>
                            null,
                        cursorWidth: 2.0,
                        cursorHeight: 20.0,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: '제목',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 80,
                      width: 260,
                      child: TextField(
                        controller: description,
                        style: TextStyle(
                          color: Colors.grey[900],
                        ),
                        maxLines: 3,
                        cursorWidth: 2.0,
                        cursorHeight: 20.0,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: '설명추가',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Color(0xfff2e6ff)),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)))),
                              onPressed: () {
                                if (loading) {
                                  return;
                                }

                                context.pop();
                                title.clear();
                                description.clear();
                              },
                              child: Text(
                                '취소',
                                style: TextStyle(color: Colors.grey[600]),
                              )),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Color(0xff40017E)),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)))),
                              onPressed: () async {
                                if (loading) {
                                  return;
                                }

                                ref
                                    .read(loadingViewModelProvider.notifier)
                                    .startLoading(3);
                                // 플레이리스트 생성 로직
                                bool isSaved = await ref
                                    .read(playListsUsecaseProvider)
                                    .addPlayList(
                                      PlayListDTO(
                                          listName: title.text,
                                          imgUrl: null,
                                          description: description.text,
                                          createdAt: DateTime.now(),
                                          songIds: []),
                                    );

                                if (!isSaved) {
                                  ref
                                      .read(loadingViewModelProvider.notifier)
                                      .endLoading();
                                  // ToastMessage
                                }

                                await ref
                                    .read(playListViewModelProvider.notifier)
                                    .getPlayLists();
                                if (context.mounted) {
                                  context.pop();
                                }
                                title.clear();
                                description.clear();
                                ref
                                    .read(cardPositionProvider.notifier)
                                    .cardPositionIndex(0);
                                ref
                                    .read(loadingViewModelProvider.notifier)
                                    .endLoading();
                              },
                              child: Text(
                                '확인',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      );
    },
  );
}

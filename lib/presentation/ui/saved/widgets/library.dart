import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:oz_player/data/dto/raw_song_dto.dart';
import 'package:oz_player/data/dto/song_dto.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/providers/raw_song_provider.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/pages/playlist_page.dart';
import 'package:oz_player/presentation/ui/saved/view_models/library_view_model.dart';
import 'package:oz_player/presentation/ui/saved/widgets/delete_alert_dialog.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';
import 'package:oz_player/presentation/widgets/card_widget/card_mini_widget.dart';

class Library extends ConsumerStatefulWidget {
  const Library({
    super.key,
  });

  @override
  ConsumerState<Library> createState() => _LibraryState();
}

class _LibraryState extends ConsumerState<Library> {
  Future<void> addSongInAudioPlayer(SongEntity data) async {
    ref.read(audioPlayerViewModelProvider.notifier).isStartLoadingAudioPlayer();
    ref.read(audioPlayerViewModelProvider.notifier).setCurrentSong(data);
    await ref
        .read(audioPlayerViewModelProvider.notifier)
        .setAudioPlayer(data.video.audioUrl, 0);
  }

  @override
  Widget build(BuildContext context) {
    final libraryAsync = ref.watch(libraryViewModelProvider);

    return libraryAsync.when(
      data: (data) {
        if (data.isEmpty) {
          return Image.asset('assets/images/library_empty.png');
        }
        return Flexible(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // 라이브러리 순서 재생성
                    final trailerLibrary = data.sublist(index, data.length);
                    final headerLibrary = data.sublist(0, index);
                    List<LibraryEntity> newLibrary = List.from(trailerLibrary)
                      ..addAll(headerLibrary);
                    context.go(
                      '/saved/library',
                      extra: [newLibrary],
                    );
                  },
                  child: Container(
                    height: 94,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // 카드 위젯 : CardMiniWidget 사용
                            SizedBox(
                              child: CardMiniWidget(
                                imgUrl: data[index].imgUrl,
                                title: data[index].title,
                                artist: data[index].artist,
                                isError: false,
                              ),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            // text
                            SizedBox(
                              width: 226,
                              height: 71,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    data[index].artist,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.gray600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '${data[index].createdAt.year}.${data[index].createdAt.month}.${data[index].createdAt.day}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: AppColors.gray400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // ------------------------
                        // 라이브러리 상세페이지 이동 버튼
                        // ------------------------
                        GestureDetector(
                          onTap: () => showModalBottomSheet<void>(
                            context: context,
                            builder: (context) => Container(
                              height: 248,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          // -----------------------
                                          // bottomsheet - 카드 이미지
                                          // -----------------------
                                          CardMiniWidget(
                                            imgUrl: data[index].imgUrl,
                                            title: data[index].title,
                                            artist: data[index].artist,
                                            isError: false,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // ---------------------
                                                // bottomsheet - 노래 제목
                                                // ---------------------
                                                Text(
                                                  data[index].title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                // ---------------------
                                                // bottomsheet - 가수
                                                // ---------------------
                                                Text(
                                                  data[index].artist,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: AppColors.gray600,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                // ---------------------
                                                // bottomsheet - 생성일자
                                                // ---------------------
                                                Text(
                                                  DateFormat('yyyy.MM.dd')
                                                      .format(data[index]
                                                          .createdAt),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: AppColors.gray400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // ---------------------
                                          // bottomsheet - 종료 버튼
                                          // ---------------------
                                          GestureDetector(
                                            onTap: () => context.pop(),
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
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
                                      // --------------------------------
                                      // library menu : 1. 재생
                                      // --------------------------------
                                      GestureDetector(
                                        onTap: () async {
                                          context.pop();
                                          final song = await ref
                                              .read(rawSongUsecaseProvider)
                                              .getRawSong(data[index].songId);
                                          if (song != null &&
                                              song.video.audioUrl != '') {
                                            addSongInAudioPlayer(SongDTO(
                                                    rawSongDto:
                                                        RawSongDto.fromEntity(
                                                            song),
                                                    libraryEntity: data[index])
                                                .toEntity());
                                          }
                                        },
                                        child: BottomSheetMenuButton(
                                            title: '음악 카드 재생'),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      // --------------------------------
                                      // playlist menu : 2. 삭제
                                      // --------------------------------
                                      GestureDetector(
                                        onTap: () async {
                                          context.pop();
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                DeleteCardAlertDialog(
                                              title: data[index].title,
                                              createdAt: data[index].createdAt,
                                            ),
                                          );
                                        },
                                        child: BottomSheetMenuButton(
                                            title: '카드 삭제'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/menu_thin_icon.png'),
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   width: 18,
                        // )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Container(
                    color: AppColors.border,
                    width: double.infinity,
                    height: 1,
                  ),
              itemCount: data.length),
        );
      },
      error: (error, stackTrace) => Container(),
      loading: () => Container(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/presentation/providers/play_list_provider.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_view_model.dart';
import 'package:oz_player/presentation/view_model/user_view_model.dart';
import 'package:oz_player/presentation/widgets/home_tap/bottom_navigation_view_model/bottom_navigation_view_model.dart';

// 플레이리스트 - 노래 삭제 BottomSheet
class DeleteSongAlertDialog extends ConsumerWidget {
  const DeleteSongAlertDialog({
    super.key,
    required this.listName,
    required this.songId,
    required this.removeSongId,
  });

  final void Function() removeSongId;
  final String listName;
  final String songId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                '선택한 음악을\n삭제하시겠어요?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.gray200),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)))),
                        onPressed: () => context.pop(),
                        child: Text(
                          '취소',
                          style: TextStyle(color: AppColors.gray600),
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
                                    borderRadius: BorderRadius.circular(8)))),
                        onPressed: () async {
                          await ref.read(playListsUsecaseProvider).deleteSong(
                              ref
                                  .read(userViewModelProvider.notifier)
                                  .getUserId(),
                              listName,
                              songId);
                          removeSongId();
                          ref
                              .read(playListViewModelProvider.notifier)
                              .getPlayLists();

                          if (context.mounted) {
                            context.pop();
                          }
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
          Positioned(
              top: -158,
              left: 0,
              right: 0,
              child: Image.asset('assets/char/oz_2.png')),
        ],
      ),
    );
  }
}

// 플레이리스트 삭제 BottomSheet
class DeletePlayListAlertDialog extends ConsumerWidget {
  const DeletePlayListAlertDialog({
    super.key,
    required this.listName,
  });

  final String listName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                '선택한 플레이리스트를\n삭제하시겠어요?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            AppColors.gray200,
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () => context.pop(),
                        child: Text(
                          '취소',
                          style: TextStyle(color: AppColors.gray600),
                        )),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.main700),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)))),
                        onPressed: () async {
                          await ref
                              .read(playListsUsecaseProvider)
                              .deletePlayList(
                                  ref
                                      .read(userViewModelProvider.notifier)
                                      .getUserId(),
                                  listName);
                          ref
                              .read(playListViewModelProvider.notifier)
                              .getPlayLists();

                          if (context.mounted) {
                            context.pop();
                            context.pop();
                          }
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
          Positioned(
              top: -158,
              left: 0,
              right: 0,
              child: Image.asset('assets/char/oz_2.png')),
        ],
      ),
    );
  }
}

// 플레이리스트 편집 - 화면 벗어날 시 알림
class CancleEditAlertDialog extends ConsumerWidget {
  const CancleEditAlertDialog({
    super.key,
    this.destination,
    this.newEntity,
    this.initialList,
  });

  final int? destination;
  final PlayListEntity? newEntity;
  final List<String>? initialList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                '플레이리스트 편집을\n그만 하시겠어요?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                '저장되지 않은 변경 사항이 있어요',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.gray200),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)))),
                        onPressed: () {
                          context.pop();
                          // 플레이리스트 수정 중에 bottomNavigation 탭 클릭한 경우
                          if (destination != null) {
                            ref
                                .read(bottomNavigationProvider.notifier)
                                .updatePage(destination!);
                          }
                          // edit 페이지에서 뒤로가기 버튼 클릭한 경우
                          else {
                            ref
                                .read(bottomNavigationProvider.notifier)
                                .updatePage(0);
                          }
                          if (destination == 0) {
                            context.go('/saved');
                          } else if (destination == 1) {
                            context.go('/home');
                          } else if (destination == 2) {
                            context.go('/search');
                          } else {
                            context.pop(
                              PlayListEntity(
                                  listName: newEntity!.listName,
                                  createdAt: newEntity!.createdAt,
                                  imgUrl: newEntity!.imgUrl,
                                  description: newEntity!.description,
                                  songIds: initialList!),
                            );
                          }
                        },
                        child: Text(
                          '그만 할게요',
                          style: TextStyle(color: AppColors.gray600),
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
                                    borderRadius: BorderRadius.circular(8)))),
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          '이어서 할게요',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              top: -158,
              left: 0,
              right: 0,
              child: Image.asset('assets/char/oz_2.png')),
        ],
      ),
    );
  }
}

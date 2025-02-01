import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/providers/play_list_provider.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_view_model.dart';

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
                                WidgetStatePropertyAll(Color(0xfff2e6ff)),
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
                          await ref
                              .read(playListsUsecaseProvider)
                              .deleteSong(listName, songId);
                          removeSongId();
                          ref
                              .read(playListViewModelProvider.notifier)
                              .getPlayLists();
                          context.pop();
                          context.pop();
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
                            backgroundColor:
                                WidgetStatePropertyAll(Color(0xfff2e6ff)),
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
                          await ref
                              .read(playListsUsecaseProvider)
                              .deletePlayList(listName);
                          ref
                              .read(playListViewModelProvider.notifier)
                              .getPlayLists();
                          context.pop();
                          context.pop();
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

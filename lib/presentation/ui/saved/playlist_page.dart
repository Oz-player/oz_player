import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/play_list_entity.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/view_models/playlist_songs_provider.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class PlaylistPage extends ConsumerStatefulWidget {
  final PlayListEntity playlist;

  const PlaylistPage({super.key, required this.playlist});

  @override
  ConsumerState<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends ConsumerState<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    final songList = ref.watch(playlistSongsProvider(widget.playlist.songIds));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '플레이리스트',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
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
                  GestureDetector(
                    onTap: () {
                      print('menu');
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      color: Colors.transparent,
                      child: Icon(
                        Icons.more_vert,
                        color: AppColors.gray400,
                      ),
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
                  Text(
                    widget.playlist.description,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColors.gray600,
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  // -----------------
                  // 플레이리스트 재생 버튼
                  // -----------------
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.main100,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      size: 44,
                      color: AppColors.main600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // ---------------
            // 음악 목록
            // ---------------
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: 300,
                child: ListView.separated(
                  itemCount: songList.length,
                  separatorBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 1,
                    color: AppColors.border,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print('song selected');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        height: 72,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                        image: NetworkImage(
                                            songList[index].imgUrl),
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
                                            songList[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            songList[index].artist,
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
                  },
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavigation(),
    );
  }
}

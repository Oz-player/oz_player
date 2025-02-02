import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/view_models/library_songs_notifier.dart';
import 'package:oz_player/presentation/ui/saved/view_models/library_view_model.dart';
import 'package:oz_player/presentation/widgets/card_widget/card_mini_widget.dart';

class Library extends ConsumerStatefulWidget {
  const Library({
    super.key,
  });

  @override
  ConsumerState<Library> createState() => _LibraryState();
}

class _LibraryState extends ConsumerState<Library> {
  @override
  Widget build(BuildContext context) {
    final libraryAsync = ref.watch(libraryViewModelProvider);

    return Flexible(
      child: libraryAsync.when(
        data: (data) {
          if (data.isEmpty) {
            return Image.asset('assets/images/library_empty.png');
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].title,
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
                        ],
                      ),
                      // ------------------------
                      // 라이브러리 상세페이지 이동 버튼
                      // ------------------------
                      GestureDetector(
                        onTap: () {
                          final songs = ref.watch(librarySongsProvider(data));
                          print('tap');
                          context.go(
                            '/saved/library',
                            extra: [data, songs],
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: 64,
                          height: 64,
                          color: Colors.transparent,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.gray200),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: AppColors.gray400,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Container(
                    color: AppColors.border,
                    width: double.infinity,
                    height: 1,
                  ),
              itemCount: data.length);
        },
        error: (error, stackTrace) => Container(),
        loading: () => Container(),
      ),
    );
  }
}

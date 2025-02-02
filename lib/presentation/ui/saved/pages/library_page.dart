import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/card_position_provider.dart';
import 'package:oz_player/presentation/widgets/card_widget/card_widget.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key, required this.library, required this.songs});

  final List<LibraryEntity> library;
  final List<SongEntity> songs;

  @override
  ConsumerState<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  // TODO positionIndex 설정
  int positionIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      positionIndex = await ref.watch(cardPositionProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background_1.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            '라이브러리',
            style: TextStyle(color: Colors.grey[900]),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.grey[900],
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Spacer(flex: 1),
                  Text(
                    '나만의\n신비로운 음악 카드',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: AppColors.gray900,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    DateFormat('yyyy.MM.dd').format(widget
                        .library[ref.watch(cardPositionProvider)].createdAt),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.gray600),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tagBox(widget
                          .library[ref.watch(cardPositionProvider)].genre),
                      tagBox(widget
                          .library[ref.watch(cardPositionProvider)].situation),
                      tagBox(widget.library[ref.watch(cardPositionProvider)]
                          .favoriteArtist),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 340,
                    child: Swiper(
                      loop: false,
                      itemBuilder: (BuildContext context, int index) {
                        final length = widget.library.length;
                        if (length == 0) {
                          return CardWidget(
                            isEmpty: true,
                            isError: true,
                          );
                        }
                        if (length == index) {
                          return CardWidget(isEmpty: true);
                        }
                        final currentSong = widget.library[index];
                        final title = currentSong.title;
                        final artist = currentSong.artist;
                        final imgUrl = currentSong.imgUrl;
                        return CardWidget(
                          title: title,
                          artist: artist,
                          imgUrl: imgUrl,
                        );
                      },
                      itemCount: widget.library.length,
                      viewportFraction: 0.5,
                      scale: 0.5,
                      fade: 0.3,
                      onIndexChanged: (index) {
                        ref
                            .read(cardPositionProvider.notifier)
                            .cardPositionIndex(index);
                      },
                    ),
                  ),
                  Spacer(
                    flex: 4,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: HomeBottomNavigation(),
      ),
    );
  }
}

Widget tagBox(String tag) {
  return Padding(
    padding: const EdgeInsets.only(right: 12, bottom: 12),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Color(0xfff2e6ff)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Text(
          tag,
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey[900],
              fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}

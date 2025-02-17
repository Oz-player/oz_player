import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:oz_player/domain/entitiy/library_entity.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/card_position_provider.dart';
import 'package:oz_player/presentation/ui/saved/widgets/card_widget_library.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key, required this.library});

  final List<LibraryEntity> library;

  @override
  ConsumerState<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  @override
  void initState() {
    super.initState();
    // 최초 인덱스 0으로 설정
    Future.microtask(() async {
      ref.read(cardPositionProvider.notifier).cardPositionIndex(0);
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
          title: Semantics(
            hint: '저장한 음악 카드를 확인할 수 있습니다.',
            child: Text(
              '라이브러리',
              style: TextStyle(color: Colors.grey[900]),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
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
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Spacer(flex: 1),
                  Semantics(
                    hint: '두 손가락으로 스와이프해서 카드를 넘겨보세요.',
                    child: Text(
                      '나만의\n신비로운 음악 카드',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          color: AppColors.gray900,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // -------------------------------------------------------
                  // 카드 생성일
                  // -------------------------------------------------------
                  Semantics(
                    label: '생성 일자',
                    child: Text(
                      DateFormat('yyyy.MM.dd').format(widget
                          .library[ref.watch(cardPositionProvider)].createdAt),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.gray600),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  // -------------------------------------------------------
                  // 태그 박스
                  // -------------------------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Semantics(
                        label: '장르',
                        child: tagBox(widget
                            .library[ref.watch(cardPositionProvider)].genre),
                      ),
                      Semantics(
                        hint: '할 때 듣는 노래',
                        child: tagBox(widget
                            .library[ref.watch(cardPositionProvider)]
                            .situation),
                      ),
                      Semantics(
                        label: '아티스트 분류',
                        child: tagBox(widget
                            .library[ref.watch(cardPositionProvider)]
                            .favoriteArtist),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  // -------------------------------------------------------
                  // Swiper 위젯
                  // -------------------------------------------------------
                  SizedBox(
                    height: 340,
                    child: Swiper(
                      loop: true,
                      itemBuilder: (BuildContext context, int index) {
                        var activeIndex = ref.read(cardPositionProvider);
                        final length = widget.library.length;
                        if (length == 0) {
                          return CardWidgetLibrary(
                            isError: true,
                          );
                        }
                        if (length == index) {
                          return CardWidgetLibrary(
                            isError: true,
                          );
                        }
                        final currentSong = widget.library[index];
                        String hint = '현재 카드';
                        if (index > activeIndex) {
                          hint = activeIndex == 0 &&
                                  index == widget.library.length - 1
                              ? '이전 카드'
                              : '다음 카드';
                        } else if (index < activeIndex) {
                          hint = index == 0 ? '다음 카드' : '이전 카드';
                        }
                        return Semantics(
                          label: hint,
                          button: true,
                          child: CardWidgetLibrary(
                            title: currentSong.title,
                            artist: currentSong.artist,
                            imgUrl: currentSong.imgUrl,
                            memo: currentSong.memo,
                            mood: currentSong.mood,
                          ),
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
              // -------------------------------------------------------
              // 오디오 플레이어
              // -------------------------------------------------------
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

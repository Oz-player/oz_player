import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/card_position_provider.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/condition_view_model.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/save_song_bottom_sheet_view_model.dart';
import 'package:oz_player/presentation/ui/recommend_page/widgets/recommend_exit_alert_dialog.dart';
import 'package:oz_player/presentation/ui/recommend_page/widgets/save_playlist_bottom_sheet.dart';
import 'package:oz_player/presentation/ui/recommend_page/widgets/save_song_bottom_sheet.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_bottomsheet.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';
import 'package:oz_player/presentation/widgets/card_widget/card_widget.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';
import 'package:oz_player/presentation/widgets/loading/loading_view_model/loading_view_model.dart';
import 'package:oz_player/presentation/widgets/loading/loading_widget.dart';

class RecommendPageConditionTwo extends ConsumerStatefulWidget {
  const RecommendPageConditionTwo({super.key});

  @override
  ConsumerState<RecommendPageConditionTwo> createState() =>
      _RecommendPageConditionTwoState();
}

class _RecommendPageConditionTwoState
    extends ConsumerState<RecommendPageConditionTwo> {
  final textControllerSaveSongMemo = TextEditingController();
  final textControllerPlaylistTitle = TextEditingController();
  final textControllerPlaylistDescription = TextEditingController();

  @override
  void dispose() {
    textControllerSaveSongMemo.dispose();
    textControllerPlaylistTitle.dispose();
    textControllerPlaylistDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final conditionState = ref.watch(conditionViewModelProvider);
    final loadingState = ref.watch(loadingViewModelProvider);
    ref.watch(saveSongBottomSheetViewModelProvider);

    return loadingState.isLoading
        ? Stack(
            children: [
              mainScaffold(conditionState),
              LoadingWidget(),
            ],
          )
        : mainScaffold(conditionState);
  }

  Widget mainScaffold(ConditionState conditionState) {
    final positionIndex = ref.watch(cardPositionProvider);

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
            '음악 카드 추천',
            style: TextStyle(color: Colors.grey[900]),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => RecommendExitAlertDialog(
                  destination: 1,
                ),
              );
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.grey[900],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Spacer(flex: 1),
              Text(
                '당신을 위해\n준비한 마법의 음악 카드',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[900],
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '원하는 카드를 저장하거나 플레이리스트에 추가해보세요',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff7303E3)),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tagBox(conditionState
                      .situation[conditionState.situationSet.first]),
                  tagBox(conditionState.genre[conditionState.genreSet.first]),
                  tagBox(conditionState.artist[conditionState.artistSet.first]),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                height: 300,
                child: Swiper(
                  loop: false,
                  itemBuilder: (BuildContext context, int index) {
                    final length = conditionState.recommendSongs.length;
                    if (length == 0) {
                      return CardWidget(
                        isEmpty: true,
                        isError: true,
                      );
                    }

                    if (length == index) {
                      return CardWidget(isEmpty: true);
                    }

                    final recommendSong = conditionState.recommendSongs[index];
                    final title = recommendSong.title;
                    final artist = recommendSong.artist;
                    final imgUrl = recommendSong.imgUrl;
                    return CardWidget(
                      title: title,
                      artist: artist,
                      imgUrl: imgUrl,
                    );
                  },
                  itemCount: conditionState.recommendSongs == []
                      ? 1
                      : conditionState.recommendSongs.length + 1,
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
                flex: 2,
              ),
              positionIndex == conditionState.recommendSongs.length
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: SizedBox(
                        height: 48,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                disabledForegroundColor: Colors.grey[400],
                                disabledBackgroundColor: Colors.grey[300],
                                backgroundColor: Colors.grey[800],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            onPressed: conditionState.event == false
                                ? null
                                : () async {
                                    await ref
                                        .read(audioPlayerViewModelProvider
                                            .notifier)
                                        .toggleStop();
                                    ref
                                        .read(
                                            conditionViewModelProvider.notifier)
                                        .recommendMusic();
                                  },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                '새로운 음악 카드 받기',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            final length = conditionState.recommendSongs.length;
                            if (length == positionIndex) {
                              return;
                            }

                            // 음악 플레이리스트에 저장
                            SavePlaylistBottomSheet.show(
                                context,
                                ref,
                                textControllerPlaylistTitle,
                                textControllerPlaylistDescription,
                                null);
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: CircleAvatar(
                            backgroundColor:
                                Colors.black.withValues(alpha: 0.32),
                            radius: 28,
                            child: Icon(
                              Icons.format_list_bulleted_add,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () {
                            final length = conditionState.recommendSongs.length;
                            if (length == positionIndex) {
                              return;
                            }
                            ref
                                .read(audioPlayerViewModelProvider.notifier)
                                .setCurrentSong(conditionState
                                    .recommendSongs[positionIndex]);
                            ref
                                .read(audioPlayerViewModelProvider.notifier)
                                .setAudioPlayer(
                                    conditionState.recommendSongs[positionIndex]
                                        .video.audioUrl,
                                    positionIndex);
                            AudioBottomSheet.show(context, positionIndex);
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: CircleAvatar(
                            backgroundColor:
                                Colors.black.withValues(alpha: 0.32),
                            radius: 28,
                            child: Icon(
                              Icons.play_arrow,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () {
                            final length = conditionState.recommendSongs.length;
                            if (length == positionIndex) {
                              return;
                            }

                            /// 보관함에 저장
                            ref
                                .read(saveSongBottomSheetViewModelProvider
                                    .notifier)
                                .setSaveSong(conditionState
                                    .recommendSongs[positionIndex]);
                            ref.read(saveSongBottomSheetViewModelProvider.notifier).isNotBlind();
                            SaveSongBottomSheet.show(
                                context, ref, textControllerSaveSongMemo);
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: CircleAvatar(
                            backgroundColor:
                                Colors.black.withValues(alpha: 0.32),
                            radius: 28,
                            child: Icon(
                              Icons.bookmark,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
              SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
        bottomNavigationBar: HomeBottomNavigation(),
      ),
    );
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
}

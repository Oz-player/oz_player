import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/providers/login/providers.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
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
import 'package:oz_player/presentation/widgets/toast_message/toast_message.dart';

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
              Semantics(
                  label: '준비 중, 잠시만 기다려주세요.',
                  child: ExcludeSemantics(child: LoadingWidget())),
            ],
          )
        : mainScaffold(conditionState);
  }

  Widget mainScaffold(ConditionState conditionState) {
    final positionIndex = ref.watch(cardPositionProvider);
    final audioState = ref.watch(audioPlayerViewModelProvider);

    if (conditionState.recommendSongs.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
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
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Image.asset(
                'assets/images/fail_recommend.png',
                fit: BoxFit.contain,
              ),
            ),
            Spacer(),
            TextButton(
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
                            .read(audioPlayerViewModelProvider.notifier)
                            .toggleStop();
                        ref
                            .read(conditionViewModelProvider.notifier)
                            .recommendMusic();
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    '다시 시도',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                )),
            SizedBox(
              height: 32,
            ),
          ],
        )),
        bottomNavigationBar: HomeBottomNavigation(),
      );
    }

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
                style: TextStyle(color: AppColors.main600),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Semantics(
                    label: '장르',
                    child: tagBox(
                        conditionState.genre[conditionState.genreSet.first]),
                  ),
                  Semantics(
                      hint: '할 때 듣는 노래',
                      child: tagBox(conditionState
                          .situation[conditionState.situationSet.first])),
                  Semantics(
                      label: '아티스트 분류',
                      child: tagBox(conditionState
                          .artist[conditionState.artistSet.first])),
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
                    var activeIndex = ref.read(cardPositionProvider);
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
                    return Semantics(
                      label: index == activeIndex
                          ? '현재 카드'
                          : index > activeIndex
                              ? '다음 카드'
                              : '이전 카드',
                      child: CardWidget(
                        title: title,
                        artist: artist,
                        imgUrl: imgUrl,
                      ),
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
                            // 음악 플레이리스트에 저장
                            SavePlaylistBottomSheet.show(
                                context,
                                ref,
                                textControllerPlaylistTitle,
                                textControllerPlaylistDescription,
                                null);
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Semantics(
                            label: '플레이리스트에 저장',
                            button: true,
                            child: CircleAvatar(
                              backgroundColor:
                                  Colors.black.withValues(alpha: 0.32),
                              radius: 28,
                              child: Icon(
                                Icons.add,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () async {
                            if (audioState.currentSong?.title ==
                                    conditionState
                                        .recommendSongs[positionIndex].title &&
                                audioState.currentSong?.artist ==
                                    conditionState
                                        .recommendSongs[positionIndex].artist &&
                                audioState.isPlaying) {
                              AudioBottomSheet.showCurrentAudio(context);
                              return;
                            }

                            if (context.mounted) {
                              AudioBottomSheet.show(context, positionIndex);
                            }
                            await ref
                                .read(audioPlayerViewModelProvider.notifier)
                                .toggleStop();

                            ref
                                .read(audioPlayerViewModelProvider.notifier)
                                .isStartLoadingAudioPlayer();

                            try {
                              if (conditionState.recommendSongs[positionIndex]
                                      .video.audioUrl ==
                                  '') {
                                final videoEx =
                                    ref.read(videoInfoUsecaseProvider);

                                final video = await videoEx.getVideoInfo(
                                    conditionState
                                        .recommendSongs[positionIndex].title,
                                    conditionState
                                        .recommendSongs[positionIndex].artist);

                                if (video.audioUrl == '' && video.id == '') {
                                  throw '${conditionState.recommendSongs[positionIndex].title} - Video is EMPTY';
                                }

                                conditionState.recommendSongs[positionIndex]
                                    .video = video;
                              }

                              ref
                                  .read(audioPlayerViewModelProvider.notifier)
                                  .setCurrentSong(conditionState
                                      .recommendSongs[positionIndex]);
                              await ref
                                  .read(audioPlayerViewModelProvider.notifier)
                                  .setAudioPlayer(
                                      conditionState
                                          .recommendSongs[positionIndex]
                                          .video
                                          .audioUrl,
                                      positionIndex);
                            } catch (e) {
                              if (mounted) {
                                ToastMessage.showErrorMessage(context);
                              }
                              ref
                                  .read(audioPlayerViewModelProvider.notifier)
                                  .isEndLoadingAudioPlayer();
                            }
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Semantics(
                            label: '재생',
                            button: true,
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
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () {
                            /// 보관함에 저장
                            ref
                                .read(saveSongBottomSheetViewModelProvider
                                    .notifier)
                                .setSaveSong(conditionState
                                    .recommendSongs[positionIndex]);
                            ref
                                .read(saveSongBottomSheetViewModelProvider
                                    .notifier)
                                .isNotBlind();
                            SaveSongBottomSheet.show(
                                context, ref, textControllerSaveSongMemo);
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Semantics(
                            label: '음악 카드 저장',
                            button: true,
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
            borderRadius: BorderRadius.circular(8), color: AppColors.main100),
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

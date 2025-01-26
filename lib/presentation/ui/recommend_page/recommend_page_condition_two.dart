import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/card_position_provider.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/condition_view_model.dart';
import 'package:oz_player/presentation/ui/recommend_page/view_model/save_song_bottom_sheet_view_model.dart';
import 'package:oz_player/presentation/ui/recommend_page/widgets/recommend_exit_alert_dialog.dart';
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
  final textController = TextEditingController();

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

    return Scaffold(
      backgroundColor: Color(0xff0d0019),
      appBar: AppBar(
        title: Text(
          '음악 카드 추천',
          style: TextStyle(color: Colors.white),
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
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.ac_unit, color: Colors.white)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Spacer(flex: 1),
            Text(
              '당신을 위해\n준비한 마법의 음악 카드',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '원하는 카드를 저장하거나 플레이리스트에 추가해보세요',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[400]),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    ref
                        .read(saveSongBottomSheetViewModelProvider.notifier)
                        .setSaveSong(
                            conditionState.recommendSongs[positionIndex]);
                    SaveSongBottomSheet.show(
                      context,
                      ref,
                      textController
                    );
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    backgroundColor: Colors.white30,
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
                    ref
                        .read(audioPlayerViewModelProvider.notifier)
                        .setCurrentSong(
                            conditionState.recommendSongs[positionIndex]);
                    ref
                        .read(audioPlayerViewModelProvider.notifier)
                        .setAudioPlayer(
                            conditionState
                                .recommendSongs[positionIndex].video.audioUrl,
                            positionIndex);
                    AudioBottomSheet.show(context, positionIndex);
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    backgroundColor: Colors.white30,
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
                  onTap: () {},
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    backgroundColor: Colors.white30,
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
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

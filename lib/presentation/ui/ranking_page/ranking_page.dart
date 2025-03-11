import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/domain/entitiy/raw_song_entity.dart';
import 'package:oz_player/domain/entitiy/song_entity.dart';
import 'package:oz_player/presentation/ui/ranking_page/view_model/ranking_view_model.dart';
import 'package:oz_player/presentation/ui/ranking_page/widgets/ranking_bottom_ground.dart';
import 'package:oz_player/presentation/ui/ranking_page/widgets/ranking_bubble.dart';
import 'package:oz_player/presentation/ui/ranking_page/widgets/ranking_intro.dart';
import 'package:oz_player/presentation/ui/ranking_page/widgets/ranking_switch.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_bottomsheet.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';

class RankingPage extends ConsumerStatefulWidget {
  const RankingPage({super.key});

  @override
  ConsumerState<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends ConsumerState<RankingPage> {
  bool isLibrary = true;

  void onButtonClicked() {
    setState(() {
      isLibrary = !isLibrary;
      ref
          .read(rankingViewModelProvider.notifier)
          .changeFocusIndex(FocusIndex.firstPrice);
    });
  }

  Future<void> playMusic(RankingState data) async {
    RawSongEntity? song;

    if (isLibrary) {
      if (data.focusIndex == FocusIndex.firstPrice) {
        song = data.cardRanking[0];
      } else if (data.focusIndex == FocusIndex.secondPrice) {
        song = data.cardRanking[1];
      } else if (data.focusIndex == FocusIndex.thirdPrice) {
        song = data.cardRanking[2];
      }
    } else {
      if (data.focusIndex == FocusIndex.firstPrice) {
        song = data.playlistRanking[0];
      } else if (data.focusIndex == FocusIndex.secondPrice) {
        song = data.playlistRanking[1];
      } else if (data.focusIndex == FocusIndex.thirdPrice) {
        song = data.playlistRanking[2];
      }
    }

    AudioBottomSheet.showCurrentAudio(context);

    ref.read(audioPlayerViewModelProvider.notifier).isStartLoadingAudioPlayer();

    SongEntity playSong = SongEntity(
        video: song!.video,
        title: song.title,
        imgUrl: song.imgUrl,
        artist: song.artist,
        mood: '',
        situation: '',
        genre: '',
        favoriteArtist: '');

    ref.read(audioPlayerViewModelProvider.notifier).setCurrentSong(playSong);

    await ref
        .read(audioPlayerViewModelProvider.notifier)
        .setAudioPlayer(playSong.video.audioUrl, -2);
  }

  @override
  Widget build(BuildContext context) {
    final rankingState = ref.watch(rankingViewModelProvider);

    return rankingState.when(
        loading: () => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/background.png'),
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        error: (err, stack) => Container(),
        data: (data) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.png'),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(
                  '뮤의 음악 랭킹',
                  style: TextStyle(color: Colors.grey[900], fontSize: 18),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
              ),
              body: Stack(
                children: [
                  SafeArea(
                      child: Column(
                    children: [
                      RankingIntro(),
                      SizedBox(
                        height: 16,
                      ),
                      RankingSwitch(
                        isLibrary: isLibrary,
                        onButtonClicked: onButtonClicked,
                      ),
                      Spacer(),
                      RankingBubble(data: data, isLibrary: isLibrary),
                      SizedBox(
                        height: 40,
                      ),
                      RankingBottomGround(
                        data: data,
                      ),
                    ],
                  )),
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
          );
        });
  }
}

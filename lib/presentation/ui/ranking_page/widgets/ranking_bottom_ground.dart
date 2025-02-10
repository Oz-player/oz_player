import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/ranking_page/view_model/ranking_view_model.dart';
import 'package:oz_player/presentation/ui/ranking_page/widgets/ranking_stage.dart';

class RankingBottomGround extends StatelessWidget {
  const RankingBottomGround({super.key, required this.data});

  final RankingState data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 72,
            child: Image.asset(
              'assets/images/ranking_background.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 100,
              child: Image.asset('assets/images/ranking_shadow.png')),
          Positioned(
              left: 120,
              right: 0,
              top: 40,
              child: Image.asset('assets/images/ranking_myu.png')),
          Positioned(
              left: 280,
              right: 0,
              top: 130,
              child: Image.asset('assets/images/ranking_star_1.png')),
          Positioned(
              left: 220,
              right: 0,
              top: 90,
              child: Image.asset('assets/images/ranking_star_2.png')),
          RankingStage(data),
        ],
      ),
    );
  }
}

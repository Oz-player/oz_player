import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';

class RankingIntro extends StatelessWidget {
  const RankingIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.main400,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 24,
              top: 36,
              child: Text(
                '가장 인기있는 TOP3를\n소개한다냥',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(8)),
                    child: SvgPicture.asset('assets/svg/myu_2.svg'))),
          ],
        ),
      ),
    );
  }
}

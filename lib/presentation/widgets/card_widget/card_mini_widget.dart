import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';

class CardMiniWidget extends ConsumerWidget {
  const CardMiniWidget(
      {super.key,
      this.imgUrl,
      this.title,
      this.artist,
      this.isError,
      this.isShade});

  final String? imgUrl;
  final String? title;
  final String? artist;
  final bool? isError;
  final bool? isShade;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          width: 48,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.43),
            color: AppColors.gray200,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.43),
                      image: DecorationImage(
                        image: NetworkImage(imgUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3.43),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.43),
                            color: Colors.black.withValues(alpha: 0.32),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 6, left: 4, right: 4, bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 39,
                          height: 39,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1.96,
                                  color: Colors.black.withValues(alpha: 0.25),
                                  offset: Offset(0, 0.49),
                                ),
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1.96),
                            child: Image.network(
                              imgUrl!,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/muoz.png',
                                  fit: BoxFit.contain,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      // 제목
                      AutoSizeText(
                        title ?? '-',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        minFontSize: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 4.66,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      // 가수 이름
                      AutoSizeText(
                        artist ?? '-',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        minFontSize: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 3.73, color: Colors.white),
                      ),
                      Spacer(
                        flex: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // isEmpty == true
        //     ? Positioned(
        //         top: 24,
        //         left: 28,
        //         child: Image.asset('assets/images/shining_2.png'))
        //     : SizedBox.shrink(),
        // isEmpty == true
        //     ? Positioned(
        //         bottom: 30,
        //         right: 24,
        //         child: Image.asset('assets/images/shining_2.png'))
        //     : SizedBox.shrink(),
      ],
    );
  }
}

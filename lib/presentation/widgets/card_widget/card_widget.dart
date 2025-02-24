import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';

class CardWidget extends ConsumerWidget {
  const CardWidget(
      {super.key,
      this.imgUrl,
      this.title,
      this.artist,
      this.isEmpty,
      this.isError,
      this.isShade});

  final String? imgUrl;
  final String? title;
  final String? artist;
  final bool? isEmpty;
  final bool? isError;
  final bool? isShade;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          width: 220,
          height: 320,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21.36),
              color: AppColors.main200,
              boxShadow: isShade == true
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null),
          child: isEmpty == true
              ? Center(
                  child: isError == true
                      ? Text(
                          'AI가 음악 카드 추천에\n실패했습니다.\n\n잠시후 다시 시도해주시거나\n태그 조합을 바꾸어서\n시도해주세요.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      : Column(
                          children: [
                            Spacer(
                              flex: 3,
                            ),
                            Text(
                              '새로운\n 추천 음악 카드',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Image.asset('assets/images/new_card.png'),
                            Spacer(
                              flex: 1,
                            ),
                          ],
                        ))
              : Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21.36),
                          image: DecorationImage(
                            image: NetworkImage(imgUrl!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(21.36),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(21.36),
                                color: Colors.black.withValues(alpha: 0.32),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 18,
                        right: 18,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 카드 이미지
                          ExcludeSemantics(
                            child: Center(
                              child: Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
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
                                        'assets/images/empty_thumbnail',
                                        fit: BoxFit.contain,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          AutoSizeText(
                            title ?? '-',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            minFontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 21.36,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          AutoSizeText(
                            artist ?? '-',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            minFontSize: 8,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 17, color: Colors.white),
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
        isEmpty == true
            ? Positioned(
                top: 24,
                left: 28,
                child: Image.asset('assets/images/shining_2.png'))
            : SizedBox.shrink(),
        isEmpty == true
            ? Positioned(
                bottom: 30,
                right: 24,
                child: Image.asset('assets/images/shining_2.png'))
            : SizedBox.shrink(),
      ],
    );
  }
}

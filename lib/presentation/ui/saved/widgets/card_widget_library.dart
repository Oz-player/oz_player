// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';

class CardWidgetLibrary extends ConsumerWidget {
  const CardWidgetLibrary({
    super.key,
    this.imgUrl,
    this.title,
    this.artist,
    this.memo,
    this.mood,
    this.isError,
  });

  final imgUrl;
  final title;
  final artist;
  final memo;
  final mood;
  final bool? isError;
  final bool? isShade = true;

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
                        offset: const Offset(0, 4.27),
                      ),
                    ]
                  : null),
          child: isError == true
              ? Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/library_empty.png'),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21.36),
                          image: DecorationImage(
                            image: NetworkImage(imgUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(21.36),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Container(
                              decoration: BoxDecoration(
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
                          Center(
                            child: Stack(
                              children: [
                                // --------------------------
                                // 곡 이미지
                                // --------------------------
                                Container(
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      imgUrl,
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
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/muoz.png',
                                          fit: BoxFit.contain,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                // --------------------------
                                // 카드 정보 확인 버튼
                                // --------------------------
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) =>
                                            memoDialog(title, memo, mood),
                                      );
                                    },
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: ClipOval(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 10,
                                            sigmaY: 10,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/list_icon.png'),
                                              ),
                                              color: Colors.black
                                                  .withValues(alpha: 0.32),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
      ],
    );
  }
}

Widget memoDialog(String title, String memo, String mood) {
  return Consumer(
    builder: (context, ref, child) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 28,
                    ),
                    Text(
                      '내가 남긴 메모',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.main100,
                      ),
                      child: Text(
                        mood,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.gray900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Flexible(
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 28,
                          left: 20,
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.gray200,
                        ),
                        child: Text(
                          memo,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.gray900,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.32),
                    image: DecorationImage(
                      image: AssetImage('assets/images/icon_close.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/pages/library_page.dart';

// 라이브러리 페이지에서 쓰는 CardWidget
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
                                          'assets/images/empty_thumbnail.png',
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
                                        builder: (context) => Semantics(
                                          label: '내가 남긴 메모 확인',
                                          child: memoDialog(title, memo, mood),
                                        ),
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
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: SizedBox(
            width: 400,
            height: 650,
            child: Stack(
              children: [
                Positioned(
                  top: 86,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 300,
                        height: 406,
                        padding: const EdgeInsets.only(
                          top: 38,
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
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
                            Semantics(
                              label: '기분',
                              child: tagBox(mood),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Flexible(
                              child: Semantics(
                                label: '내용',
                                child: Container(
                                  width: 259,
                                  height: 170,
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    left: 20,
                                    right: 20,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        width: 1,
                                        color: AppColors.border,
                                      )),
                                  child: ListView(
                                    children: [
                                      Text(
                                        memo,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: AppColors.gray900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            SizedBox(
                              width: 246,
                              height: 40,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(AppColors.main700),
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  context.pop();
                                },
                                child: Text(
                                  '확인',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 533,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/char/oz_2.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

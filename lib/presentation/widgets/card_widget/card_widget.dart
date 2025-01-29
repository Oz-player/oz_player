import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardWidget extends ConsumerWidget {
  const CardWidget(
      {super.key,
      this.imgUrl,
      this.title,
      this.artist,
      this.isEmpty,
      this.isError,
      this.isShade});

  final imgUrl;
  final title;
  final artist;
  final bool? isEmpty;
  final bool? isError;
  final bool? isShade;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 205,
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: isShade == true
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xff40017E)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 28),
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
                : Column(
                    children: [
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(12)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      AutoSizeText(
                        artist ?? '-',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        minFontSize: 8,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

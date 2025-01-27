import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavePlaylistBottomSheet {
  static void show(BuildContext context, WidgetRef ref) async {
    final openSheet = await showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: true,
        isScrollControlled: true,
        builder: (context) {
          return Consumer(
            builder: (context, ref, child) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                ),
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: double.maxFinite,
                        ),
                        Container(
                          height: 5,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[400],
                          ),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        Text(
                          '이 음악을 나의\n플레이리스트에 추가',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        });

    /// 드래그로 닫을 경우 호출됨
    if (openSheet == null) {
      await Future.delayed(Duration(milliseconds: 500));
    }
  }
}

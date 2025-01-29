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
                    Stack(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 8),
                                    child: Text(
                                      '정렬 기준',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print('tap');
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      color: Colors.transparent,
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colors.grey[300],
                                        ),
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: double.infinity,
                                height: 480,
                                child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) => Container(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    height: 80,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                // 플레이리스트 대표 이미지
                                                Container(
                                                  width: 56,
                                                  height: 56,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                // 플레이리스트 내용
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 18),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '플레이리스트 이름 플레이리스트 이름',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Text(
                                                          '00개의 곡',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                          ],
                        ),
                        Positioned(
                          right: 20,
                          bottom: 32,
                          child: FloatingActionButton(
                            onPressed: () {
                              
                            },
                            shape: CircleBorder(),
                            backgroundColor: Color(0xff7303E3),
                            child: Icon(Icons.add, size: 28, color: Colors.white,),
                            )
                          ),
                      ],
                    ),
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

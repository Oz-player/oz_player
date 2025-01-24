import 'package:flutter/material.dart';
import 'package:oz_player/presentation/ui/saved/widgets/saved_tab_button.dart';
import 'package:oz_player/presentation/widgets/home_tap/home_bottom_navigation.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  bool isLibrary = true;

  @override
  void initState() {
    super.initState();
  }

  void onButtonClicked() {
    setState(() {
      isLibrary = !isLibrary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '보관함',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 탭 이동 버튼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SavedTabButton(
                  title: '라이브러리',
                  isLibrary: isLibrary,
                  onClicked: onButtonClicked,
                ),
                SavedTabButton(
                  title: '플레이리스트',
                  isLibrary: !isLibrary,
                  onClicked: onButtonClicked,
                ),
                Text('$isLibrary'),
              ],
            ),
          ),
          // 정렬 기준
          // 내용
        ],
      ),
      bottomNavigationBar: HomeBottomNavigation(),
    );
  }
}

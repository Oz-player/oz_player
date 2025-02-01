import 'package:flutter/material.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/recommend_page/widgets/save_playlist_bottom_sheet.dart';

class CreatePlaylistButton extends StatelessWidget {
  const CreatePlaylistButton({
    super.key,
    required this.title,
    required this.description,
  });

  final TextEditingController title;
  final TextEditingController description;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 110,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => playlistDialog(title, description));
          },
          child: Container(
            width: 120,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppColors.gray800,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    '새로 만들기',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                SizedBox(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SavedTabButton extends StatelessWidget {
  const SavedTabButton({
    super.key,
    required this.title,
    required this.isLibrary,
    required this.onClicked,
  });

  final void Function() onClicked;
  final String title;
  final bool isLibrary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: !isLibrary
              ? BorderSide(
                  color: Colors.black,
                  width: 1,
                )
              : null,
          backgroundColor: isLibrary ? Colors.black : Colors.white,
        ),
        onPressed: onClicked,
        child: Text(
          title,
          style: TextStyle(
            color: isLibrary ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

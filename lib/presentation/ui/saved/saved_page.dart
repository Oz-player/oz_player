import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('보관함'),
      ),
      body: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                isLibrary = true;
              });
            },
            child: Text(
              'Library',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isLibrary = false;
              });
            },
            child: Text('playlist'),
          ),
          Text('$isLibrary'),
        ],
      ),
    );
  }
}

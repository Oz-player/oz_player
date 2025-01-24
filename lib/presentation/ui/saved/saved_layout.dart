import 'package:flutter/material.dart';

class SavedLayout extends StatefulWidget {
  const SavedLayout({super.key});

  @override
  State<SavedLayout> createState() => _SavedLayoutState();
}

class _SavedLayoutState extends State<SavedLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('보관함'),
      ),
      body: Container(),
    );
  }
}

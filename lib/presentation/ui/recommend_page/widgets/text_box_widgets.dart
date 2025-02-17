import 'package:flutter/material.dart';

class TextBoxWidgets extends StatefulWidget {
  const TextBoxWidgets({super.key, required this.state});
  final dynamic state;

  @override
  State<TextBoxWidgets> createState() => _TextBoxWidgetsState();
}

class _TextBoxWidgetsState extends State<TextBoxWidgets> {
    double _opacity = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      _opacity = 0.0;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Center(
            widthFactor: 1.0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Text(
                widget.state.textList[widget.state.index],
                key: ValueKey(widget.state.index),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[900]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

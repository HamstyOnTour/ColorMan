import 'package:flutter/material.dart';

class ColoredBoxWidget extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onClick;

  const ColoredBoxWidget(
      {required this.color, required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onClick,
        child: Container(
          width: 200, // Change width as needed
          height: 200, // Change height as needed
          color: color,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ));
  }
}

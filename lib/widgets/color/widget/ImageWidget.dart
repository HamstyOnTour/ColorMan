import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  final String text;
  final Function onClick;
  final double width;
  final double height;

  const ImageWidget({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onClick,
    this.width = 100,
    this.height = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick as void Function()?,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: width,
            height: height,
          ),
          SizedBox(height: 8),
          Text(text),
        ],
      ),
    );
  }
}
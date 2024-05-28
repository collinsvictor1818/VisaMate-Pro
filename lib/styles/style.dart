import 'package:visamate/styles/pallete.dart';
import 'package:flutter/material.dart';
import 'package:visamate/styles/pallete.dart';

class PrimaryText extends StatelessWidget {
  final double size;
  final FontWeight fontWeight;
  final Color? color;
  final String text;
  final double height;

  const PrimaryText({
    required this.text,
    this.fontWeight = FontWeight.w700,
    this.color,
    this.size = 20,
    this.height = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        height: height,
        fontFamily: 'Gilmer',
        fontSize: size,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis
      ),
    );
  }
}

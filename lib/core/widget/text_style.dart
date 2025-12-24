import 'package:flutter/material.dart';
import 'package:untitled7/core/color/app_colors.dart';

class TextStyle extends StatelessWidget {
  final Color color;
  final int fontSize;
  final FontWeight fontWeight;
  const TextStyle({super.key,required this.color,required this.fontSize,required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return TextStyle(
        color: AppColor.black,
        fontSize: 36,
        fontWeight: FontWeight.bold);
  }
}

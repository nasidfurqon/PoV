import 'package:flutter/material.dart';

class CustomHighlightDashboard extends StatelessWidget {
  final String title;
  final bool? customFontStyle;
  final FontWeight? fontWeight;
  final double? fontSize;
  final EdgeInsets? padding;
  final Color fontColor;
  final Color containerColor;
  const CustomHighlightDashboard({super.key, this.customFontStyle = false, this.fontWeight, this.fontSize, this.padding, required this.title, required this.fontColor, required this.containerColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: containerColor ,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
        title,
        style: customFontStyle == false ? TextStyle(
            color: fontColor,
          fontSize: 13
        ) :
        TextStyle(
            color: fontColor,
            fontSize: fontSize,
            fontWeight: fontWeight
        )
      ),
    );
  }
}

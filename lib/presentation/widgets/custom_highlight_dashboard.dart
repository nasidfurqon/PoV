import 'package:flutter/material.dart';

class CustomHighlightDashboard extends StatelessWidget {
  final String title;
  final Color fontColor;
  final Color containerColor;
  const CustomHighlightDashboard({super.key, required this.title, required this.fontColor, required this.containerColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: containerColor ,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
        title,
        style: TextStyle(
            color: fontColor,
          fontSize: 13
        ),
      ),
    );
  }
}

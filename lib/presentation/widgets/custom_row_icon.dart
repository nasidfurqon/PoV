import 'package:flutter/material.dart';

import '../../config/theme/app_spacing.dart';

class CustomRowIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final TextStyle textStyle;
  const CustomRowIcon({super.key, required this.icon, required this.color, required this.title, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color,),
        SizedBox(width: AppSpacing.xxs),
        Text(title, style: textStyle)
      ],
    );
  }
}

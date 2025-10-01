import 'package:flutter/material.dart';

import '../../config/theme/app_spacing.dart';

class CustomRowIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final dynamic title;
  final TextStyle textStyle;
  const CustomRowIcon({super.key, required this.icon, required this.color, required this.title, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color,),
        SizedBox(width: AppSpacing.xxs),
        title is Future<String?> ?
        FutureBuilder<String?>(
          future: title as Future<String?>,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("...");
            } else if (snapshot.hasError) {
              return const Text('');
            } else {
              return Text(
                snapshot.data!,
                style: textStyle,
              );
            }
          },) :
        Text(title, style: textStyle)
      ],
    );
  }
}

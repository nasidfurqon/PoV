import 'package:flutter/material.dart';

import '../../config/theme/app_spacing.dart';
import '../../config/theme/app_text.dart';

class CustomHeaderVisit extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const CustomHeaderVisit({super.key, required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
          size: AppSpacing.xxl,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  title,
                  style: AppText.heading3
              ),
              const SizedBox(height: 4),
              Text(
                  description,
                  style: AppText.bodySecondary
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomHeader2Visit extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const CustomHeader2Visit({super.key, required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
          size: AppSpacing.xl,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  title,
                  style: AppText.heading5
              ),
              const SizedBox(height: 4),
              Text(
                  description,
                  style: AppText.caption
              ),
            ],
          ),
        ),
      ],
    );
  }
}

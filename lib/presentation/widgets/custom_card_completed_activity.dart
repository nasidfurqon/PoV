import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_card.dart';

import 'custom_highlight_dashboard.dart';

class CustomCardCompletedActivity extends StatelessWidget {
  final String place;
  final String date;
  final String time;
  final String score;
  const CustomCardCompletedActivity({super.key, required this.place, required this.date, required this.time, required this.score});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place,
                style: AppText.heading3,
              ),
              SizedBox(height: AppSpacing.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${date} at ${time}',
                    style: AppText.caption,
                  ),
                  Row(
                    children: [
                      CustomHighlightDashboard(title: '${score}/100', fontColor: AppColor.textPrimary, containerColor: AppColor.border),
                      SizedBox(width: AppSpacing.xs,),
                      CustomHighlightDashboard(title: 'completed', fontColor: AppColor.accentCompleted, containerColor: AppColor.onAccentCompleted),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
    );
  }
}

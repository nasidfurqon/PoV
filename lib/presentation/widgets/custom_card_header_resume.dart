import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';

class CustomCardHeaderResume extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String number;
  final String description;
  const CustomCardHeaderResume({super.key, required this.title, required this.icon, required this.color, required this.number, required this.description});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        padding: EdgeInsets.zero,
        // height: 175,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.global),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppText.body,
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.all(AppSpacing.xs),
                    child: Icon(
                      icon,
                      color: color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.sm,),
              Text(
                number,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: color
                ),
              ),
              SizedBox(height: AppSpacing.xxs,),
              Text(
                description,
                style: AppText.caption,
              )
            ],
          ),
        )
    );
  }
}

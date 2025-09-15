import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:pov2/presentation/widgets/custom_row_icon.dart';
import 'package:go_router/go_router.dart';
import '../../config/router/app_routes.dart';
import '../../core/widget/custom_button.dart';

class CustomCardJobList extends StatelessWidget {
  final String id;
  final String place;
  final String progress;
  final String status;
  final String deadline;
  final String visitor;
  final String description;
  const CustomCardJobList({super.key, required this.id, required this.place, required this.progress, required this.status, required this.deadline, required this.visitor, required this.description});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.global),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    place,
                    style: AppText.heading3,
                  ),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomHighlightDashboard(title: progress, fontColor: ParsingColor.cekColor(progress)[0], containerColor: ParsingColor.cekColor(progress)[1]),
                      SizedBox(height: AppSpacing.xs,),
                      CustomHighlightDashboard(title: status, fontColor: ParsingColor.cekColor(status)[0], containerColor: ParsingColor.cekColor(status)[1])
                    ],
                  )
                ],
              ),
              SizedBox(height: AppSpacing.lg),
              CustomRowIcon(icon: Icons.location_on_outlined, color: AppColor.textSecondary, title: place, textStyle: AppText.caption),
              SizedBox(height: AppSpacing.sm),
              CustomRowIcon(icon: Icons.calendar_today_outlined, color: AppColor.textSecondary, title: deadline, textStyle: AppText.caption),
              SizedBox(height: AppSpacing.sm),
              CustomRowIcon(icon: Icons.person, color: AppColor.textSecondary, title: visitor, textStyle: AppText.caption),
              SizedBox(height: AppSpacing.sm),
              Text(
                description,
                style: AppText.caption,
              ),
              SizedBox(height: AppSpacing.sm,),
              if(!(progress == 'Selesai'))
              CustomButtonFull(
                icon: Icons.check_circle_outline,
                textStyle: AppText.heading3Tertiary,
                title: 'Start Visit',
                backgroundColor: AppColor.primary,
                padding: EdgeInsets.all(2),
                onPressed: () {
                  context.pushNamed(AppRoutes.visit.name, pathParameters: {
                    'id': id.toString()
                  });
                },
              ),
            ],
          ),
        )
    );
  }
}

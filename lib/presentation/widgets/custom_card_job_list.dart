import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_helper.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/data/models/jobList_model.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:pov2/presentation/widgets/custom_row_icon.dart';
import 'package:go_router/go_router.dart';
import '../../config/router/app_routes.dart';
import '../../core/widget/custom_button.dart';

class CustomCardJobList extends StatelessWidget {
  final JobListModel scheduleData;
  const CustomCardJobList({super.key, required this.scheduleData});

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
                    scheduleData.locationName ?? '',
                    style: AppText.heading3,
                  ),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomHighlightDashboard(title: scheduleData.scheduleStatus ?? '', fontColor: ParsingColor.cekColor(scheduleData.scheduleStatus ?? '')[0], containerColor: ParsingColor.cekColor(scheduleData.scheduleStatus ?? '')[1]),
                      SizedBox(height: AppSpacing.xs,),
                      CustomHighlightDashboard(title: scheduleData.schedulePriority ?? '', fontColor: ParsingColor.cekColor(scheduleData.schedulePriority ?? '')[0], containerColor: ParsingColor.cekColor(scheduleData.schedulePriority ?? '')[1])
                    ],
                  )
                ],
              ),
              Divider(),
              SizedBox(height: AppSpacing.xs),
              CustomRowIcon(icon: Icons.location_on_outlined, color: AppColor.textSecondary, title: scheduleData.locationAddress ?? '', textStyle: AppText.caption),
              SizedBox(height: AppSpacing.xs),
              CustomRowIcon(icon: Icons.calendar_today_outlined, color: AppColor.textSecondary, title: ParsingHelper.splitTimePre(scheduleData.endDateTime ?? ''), textStyle: AppText.caption),
              SizedBox(height: AppSpacing.xs),
              CustomRowIcon(icon: Icons.person, color: AppColor.textSecondary, title: scheduleData.fullName ?? '', textStyle: AppText.caption),
              SizedBox(height: AppSpacing.xs),
              Text(
                scheduleData.visitationDescription ?? '',
                style: AppText.caption,
              ),
              SizedBox(height: AppSpacing.sm,),
              if(!((scheduleData.scheduleStatus ?? '') == 'Completed'))
              CustomButtonFull(
                icon: Icons.check_circle_outline,
                textStyle: AppText.heading3Tertiary,
                title: scheduleData.actualStartDateTime == '' || scheduleData.actualStartDateTime == null ? 'Start Visit' : 'Continue Visit',
                backgroundColor: AppColor.primary,
                padding: EdgeInsets.all(2),
                onPressed: () {
                  context.pushNamed(AppRoutes.visit.name, pathParameters: {
                    'id': scheduleData.trVisitationScheduleID.toString()
                  },
                      extra:  scheduleData,);
                },
              ),
            ],
          ),
        )
    );
  }
}

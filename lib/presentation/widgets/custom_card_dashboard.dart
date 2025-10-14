import 'package:flutter/material.dart';
import 'package:pov2/config/router/app_routes.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_helper.dart';
import 'package:pov2/core/widget/custom_allert.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/data/models/mtLocation_model.dart';
import 'package:pov2/data/models/trVisitationSchedule_model.dart';
import 'package:pov2/data/services/update_service.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/parsing_status_color.dart';
import '../../data/models/jobList_model.dart';
class CustomCardDashboard extends StatelessWidget {
  final JobListModel scheduleData;
  const CustomCardDashboard({
    super.key, required this.scheduleData,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(scheduleData.locationName ?? '', style: AppText.heading3),
                CustomHighlightDashboard(title: scheduleData.schedulePriority ?? '', fontColor: ParsingColor.cekColor(scheduleData.schedulePriority ?? '')[0], containerColor: ParsingColor.cekColor(scheduleData.schedulePriority ?? '' )[1])
              ],
            ),
            SizedBox(height: AppSpacing.sm,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(scheduleData.locationAddress ?? '', style: AppText.caption),
                CustomHighlightDashboard(title: scheduleData.scheduleStatus ?? '', fontColor: ParsingColor.cekColor(scheduleData.scheduleStatus ?? '')[0], containerColor: ParsingColor.cekColor(scheduleData.scheduleStatus ?? '')[1])

              ],
            ),
            SizedBox(height: AppSpacing.sm,),
            Row(
              children: [
                Icon(Icons.watch_later_outlined, color: AppColor.textSecondary,),
                SizedBox(width: 2,),
                Text('${ParsingHelper.splitTimePost(scheduleData.startDateTime ?? '')} - ${ParsingHelper.splitTimePost(scheduleData.endDateTime ?? '')}', style: AppText.caption),
                SizedBox(width: AppSpacing.md,),
                Icon(Icons.location_on_outlined, color: AppColor.textSecondary,),
                Text('${scheduleData.geofence ?? ''}m radius', style: AppText.caption)
              ],
            ),
            SizedBox(height: AppSpacing.sm,),
            Text(scheduleData.visitationDescription ?? '', style: AppText.caption,),
            SizedBox(height: AppSpacing.sm,),
            CustomButtonFull(
              icon: Icons.check_circle_outline,
              iconColor: scheduleData.actualStartDateTime == '' || scheduleData.actualStartDateTime == null ? AppColor.textTertiary : AppColor.primary,
              textStyle: scheduleData.actualStartDateTime == '' || scheduleData.actualStartDateTime == null ? AppText.heading3Tertiary: AppText.heading3Primary,
              title: scheduleData.actualStartDateTime == '' || scheduleData.actualStartDateTime == null ? 'Start Visit' : 'Continue Visit',
              borderSide: BorderSide(
                  width: scheduleData.actualStartDateTime == '' || scheduleData.actualStartDateTime == null ? 0: 1,
                  color: AppColor.primary
              ),
              backgroundColor:scheduleData.actualStartDateTime == '' || scheduleData.actualStartDateTime == null ? AppColor.primary : AppColor.textTertiary,
              padding: EdgeInsets.all(2),
              onPressed: () async{
                if(scheduleData.actualStartDateTime == '' || scheduleData.actualStartDateTime == null){
                  final isConfirmed = await CustomAller().showConfirmDialog(
                      context, 'Confirm',
                      'are you sure want to start visit this schedule?');
                  if (isConfirmed) {
                    print('CEK ACTUAL DATE = ${scheduleData
                        .actualStartDateTime}');
                    if (scheduleData.actualStartDateTime == '' ||
                        scheduleData.actualStartDateTime == null) {
                      var updateActStartDate = UpdateService
                          .trVisitationSchedule(
                          scheduleData.trVisitationScheduleID.toString(), {
                        'ActualStartDateTime': DateTime.now().toIso8601String(),
                        'Status': 'OnProgress',
                      });

                      if (updateActStartDate == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Internal Server Error'),
                              backgroundColor: AppColor.error,));
                      }
                    }
                    context.pushNamed(AppRoutes.visit.name, pathParameters: {
                      'id': scheduleData.trVisitationScheduleID.toString(),
                    },
                      extra: scheduleData,
                    );
                  }
                }
                else{
                  context.pushNamed(AppRoutes.visit.name, pathParameters: {
                    'id': scheduleData.trVisitationScheduleID.toString(),
                  },
                    extra: scheduleData,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

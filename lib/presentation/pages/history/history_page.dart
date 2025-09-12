import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_layout.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';
import 'package:pov2/presentation/widgets/custom_card_completed_activity.dart';

import '../../../data/services/visit_data.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> visitUncompleted = VisitData().taskData.where((task){
      return task['isCompleted'] == true;
    }).toList();

    final data = visitUncompleted[0];
    return CustomScaffold(
      body: AppLayout(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.global),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSpacing.xs),
                Text(
                  'Recent Activity',
                  style: AppText.heading1Tertiary,
                ),
                SizedBox(height: AppSpacing.sm,),
                CustomCardCompletedActivity(place: data['place'], date: '9/10/2025', time: '7:24:52 AM', score: '90')
              ],
            ),
          )
      ),
    );
  }
}

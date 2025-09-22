import 'package:flutter/material.dart';
import 'package:pov2/core/widget/custom_dashboard_page.dart';
import 'package:pov2/presentation/widgets/custom_header_card.dart';

import '../../../config/theme/app_color.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_text.dart';
import '../../../core/utils/format_date.dart';
import '../../../core/widget/custom_button.dart';
import '../../../data/services/visit_data.dart';
import '../../widgets/custom_card_dashboard.dart';

class DashboardFieldOfficerPage extends StatefulWidget {
  const DashboardFieldOfficerPage({super.key});

  @override
  State<DashboardFieldOfficerPage> createState() => _DashboardFieldOfficerPageState();
}

class _DashboardFieldOfficerPageState extends State<DashboardFieldOfficerPage> {
  List<Map<String, dynamic>> visitUncompleted = VisitData().taskData.where((task){
    return task['isCompleted'] == false;
  }).toList();

  @override
  Widget build(BuildContext context) {
    return CustomDashboard(
        user: 'Field Officer',
        child: (controller) =>  _cardActivity(controller)
    );
  }

  Widget _cardActivity(ScrollController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:   AppSpacing.global),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomHeaderCard(
                    number: '2',
                    status: 'Completed'
                ),
              ),
              SizedBox(width: AppSpacing.xs,),
              Expanded(
                child: CustomHeaderCard(
                    number: '2',
                    status: 'Scheduled'
                ),
              ),
              SizedBox(width: AppSpacing.xs,),
              Expanded(
                child: CustomHeaderCard(
                    number: '95%',
                    status: 'PoV Score'
                ),
              )
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Today's Visit", style: AppText.heading2,),
              CustomButton(
                iconColor: AppColor.textTertiary,
                icon: Icons.date_range_outlined,
                textStyle: AppText.bodyTertiary,
                title: FormatDate.formateddDate(DateTime.now()),
                backgroundColor: AppColor.primary,
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: AppSpacing.global),
          Expanded(
            child: ListView.separated(
              controller: controller,
              itemBuilder: (BuildContext context, int index){
                final data = visitUncompleted[index];
                return CustomCardDashboard(
                    place: data['place'],
                    status: data['status'],
                    street: data['street'],
                    city: data['city'],
                    hourfrom: data['hourFrom'],
                    hourTo: data['hourTo'],
                    radius: data['radius'],
                    description: data['description'],
                    id: index
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: AppSpacing.global);
              },
              itemCount: visitUncompleted.length,
            ),
          ),
        ],
      ),
    );
  }
}

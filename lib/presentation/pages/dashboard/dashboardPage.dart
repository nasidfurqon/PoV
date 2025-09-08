import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/format_date.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_layout.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';
import 'package:pov2/data/services/visitData.dart';
import 'package:pov2/presentation/widgets/custom_card_dashboard.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Map<String, dynamic>> visitUncompleted = VisitData().taskData.where((task){
    return task['isCompleted'] == false;
  }).toList();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: AppLayout(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.global),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              SizedBox(height: AppSpacing.global),
              _cardActivity()
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/icon.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: AppSpacing.lg),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PoV Dashboard', style: AppText.headingTertirary),
                Text(
                  'Welcome back, Administrator',
                  style: AppText.bodySecondary,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _cardActivity() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Today's Visit", style: AppText.heading2Secondary,),
            CustomButton(
              iconColor: AppColor.textPrimary,
              icon: Icons.date_range_outlined,
              textStyle: AppText.body,
              title: FormatDate.formateddDate(DateTime.now()),
              backgroundColor: AppColor.background,
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: AppSpacing.global),
        SizedBox(
          height: 500,
          child: ListView.separated(
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
    );
  }
}

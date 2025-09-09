import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/format_date.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_layout.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';
import 'package:pov2/data/services/visitData.dart';
import 'package:pov2/presentation/pages/dashboard/quickMenu.dart';
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
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.global),
              child: Column(
                children: [
                  _header(),
                  SizedBox(height: AppSpacing.lg),
                  QuickMenu(status: 'status'),
                ],
              ),
            ),
            DraggableScrollableActuator(
              child: DraggableScrollableSheet(
                initialChildSize: 0.65,
                minChildSize: 0.65,
                snap: true,
                maxChildSize: 1,
                snapSizes: const [0.65, 1],
                builder: (context, scrollController){
                  return CustomCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                          children: [
                            Center(
                              child: Container(
                                width: 40,
                                height: 7,
                                margin: EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Expanded(child: _cardActivity(scrollController))
                          ],
                    )
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        SizedBox(height: AppSpacing.xs),
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
                  style: AppText.bodyTertiary,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _cardActivity(ScrollController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:   AppSpacing.global),
      child: Column(
        children: [
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

import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/format_date.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_layout.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';
import 'package:pov2/data/services/visit_data.dart';
import 'package:pov2/presentation/pages/dashboard/quickMenu.dart';
import 'package:pov2/presentation/widgets/custom_card_dashboard.dart';

class CustomDashboard extends StatefulWidget {
  final String user;
  final Widget Function(ScrollController scrollController) child;
  const CustomDashboard({super.key, required this.user, required this.child});

  @override
  State<CustomDashboard> createState() => _CustomDashboardState();
}

class _CustomDashboardState extends State<CustomDashboard> {
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
                  QuickMenu(),
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
                          Expanded(child: widget.child(scrollController))
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
                  maxLines: 2,
                  'Welcome back, ${widget.user}',
                  style: AppText.bodyTertiary,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

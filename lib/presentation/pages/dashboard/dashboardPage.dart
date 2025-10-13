import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/format_date.dart';
import 'package:pov2/core/utils/parsing_helper.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_dashboard_page.dart';
import 'package:pov2/core/widget/custom_layout.dart';
import 'package:pov2/core/widget/custom_progress_indicator.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';
import 'package:pov2/data/models/jobList_model.dart';
import 'package:pov2/data/models/mtLocation_model.dart';
import 'package:pov2/data/models/trVisitationSchedule_model.dart';
import 'package:pov2/data/services/visit_data.dart';
import 'package:pov2/presentation/pages/dashboard/quickMenu.dart';
import 'package:pov2/presentation/widgets/custom_card_dashboard.dart';

import '../../../data/services/get_service.dart';

class DashboardPage extends StatefulWidget {
  final dynamic ID;
  const DashboardPage({super.key, required this.ID});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String name = '';
  List<JobListModel> listSchedule = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadName();
    _loadListSchedule();
  }


  Future<void> _loadName() async {
    final res = await GetService.name(widget.ID);
    setState(() {
      name = res;
    });
  }

  Future<void> _loadListSchedule() async{
    List<JobListModel> res = await GetService.getListJobToday(widget.ID);
    setState(() {
      listSchedule = res  ;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomDashboard(
        user: name,
        child: (controller) => _cardActivity(controller)
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
          if(isLoading)
            Center(child: CircularProgressIndicator(),),
          if(listSchedule.isEmpty && !isLoading)
          CustomProgressIndicator.showInformation(context, 'Tidak ada jadwal', 'Info'),
          Expanded(
            child: ListView.separated(
                controller: controller,
                itemBuilder: (BuildContext context, int index){
                  final data = listSchedule[index];
                  return CustomCardDashboard(
                    scheduleData: data,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: AppSpacing.global);
                },
                itemCount: listSchedule.length,
            ),
          ),
        ],
      ),
    );
  }
}

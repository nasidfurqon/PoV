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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/services/get_service.dart';
import '../../../data/services/user_notifier.dart';
import '../../../data/services/visitationProvider.dart';

class DashboardPage extends ConsumerStatefulWidget {
  final dynamic ID;
  const DashboardPage({super.key, required this.ID});
  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  // String name = '';
  // List<JobListModel> listSchedule = [];
  // bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // _loadName();
    // Future(() async {
    //   await ref.read(visitationTodayProvider.notifier).reload();
    // });
    // _loadListSchedule();
  }


  // Future<void> _loadName() async {
  //   final res = await GetService.name(widget.ID);
  //   setState(() {
  //     name = res;
  //   });
  // }

  // Future<void> _loadListSchedule() async{
  //   List<JobListModel> res = await GetService.getListJobToday(widget.ID);
  //   setState(() {
  //     listSchedule = res  ;
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final today = ref.watch(visitationTodayProvider);
    final userData = ref.watch(userProvider);

    return CustomDashboard(
        user: userData!.fullName ?? '',
        child: (controller) => today.when(
          data: (listSchedule) =>
              _cardActivity(controller, listSchedule),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
    );
  }

  Widget _cardActivity(ScrollController controller, List<JobListModel> listSchedule) {
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
          // if(isLoading)
          //   Center(child: CircularProgressIndicator(),),
          if(listSchedule.isEmpty)
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
          SizedBox(height: AppSpacing.xxxl),

        ],
      ),
    );
  }
}

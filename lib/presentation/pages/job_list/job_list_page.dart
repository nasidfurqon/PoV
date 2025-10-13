import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_helper.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/core/widget/custom_progress_indicator.dart';
import 'package:pov2/data/models/jobList_model.dart';
import 'package:pov2/data/models/trVisitationSchedule_model.dart';
import 'package:pov2/data/services/count_service.dart';
import 'package:pov2/data/services/visit_data.dart';
import 'package:pov2/presentation/widgets/custom_card_job_list.dart';
import 'package:pov2/presentation/widgets/custom_header_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/services/get_service.dart';
class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  int onGoingCount = 0;
  int waitingCount =0;
  int finishCount = 0;
  List<JobListModel> listSchedule = [];
  late SharedPreferences pref;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async{
    pref = await SharedPreferences.getInstance();
    dynamic userId = pref.getString('userId');
    int cntOnGoing = await CountService.countStatus('OnProgress', userId);
    int cntWaiting = await CountService.countStatus('Scheduled', userId);
    int cntFinish = await CountService.countStatus('Completed', userId);
    setState(() {
      onGoingCount = cntOnGoing;
      waitingCount = cntWaiting;
      finishCount = cntFinish;
    });

    List<JobListModel> res = await GetService.getListJob(userId);
    setState(() {
      listSchedule = res  ;
      isLoading = false;
    });

  }
  @override
  Widget build(BuildContext context) {
    return CustomNormalScaffold(
        context: context,
        title: Text(
          'Daftar Tugas',
          style: AppText.heading2,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.global),
          child: isLoading ? Center(child: CircularProgressIndicator(),) :listSchedule.isEmpty ?
              CustomProgressIndicator.showInformation(context, 'Tidak ada tugas', 'Info'):
          ListView(
            children: [
              CustomHeaderCard(
                  number: waitingCount.toString(),
                  status: 'Menunggu'
              ),
              SizedBox(height: AppSpacing.sm,),
              CustomHeaderCard(
                  number: onGoingCount.toString(),
                  status: 'Berlangsung'
              ),
              SizedBox(height: AppSpacing.sm,),
              CustomHeaderCard(
                  number: finishCount.toString(),
                  status: 'Selesai'
              ),
              SizedBox(height: AppSpacing.sm,),
              ...listSchedule.asMap().entries.map((entry){
                final data = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: CustomCardJobList(
                    scheduleData: data,
                  ),
                );
              })
            ],
          ),
        )
    );
  }
}

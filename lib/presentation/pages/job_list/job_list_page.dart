import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_helper.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
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
  List<TRVisitationScheduleModel> listSchedule = [];
  late SharedPreferences pref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadListSchedule();
    _getCountData();
  }

  Future<void> _loadListSchedule() async{
    pref = await SharedPreferences.getInstance();
    dynamic userId = pref.getString('userId');
    List<TRVisitationScheduleModel> res = await GetService.getListSchedule(userId);
    setState(() {
      listSchedule = res  ;
    });
  }
  
  Future<void> _getCountData() async{
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
          child: ListView(
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
                      id: data.id.toString(),
                      place: GetService.getLocationbyID(data.mtLocationId).then((data)=>data?.name),
                      progress: data.status ?? '-',
                      status: data.priority ?? '-',
                      deadline: ParsingHelper.splitTimePre(data.startDateTime),
                      visitor: GetService.name(pref.getString('userId')),
                      description: data.visitationDescription ?? '-'
                  ),
                );
              })
            ],
          ),
        )
    );
  }
}

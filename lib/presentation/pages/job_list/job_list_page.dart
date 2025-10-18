import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_helper.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/core/widget/custom_progress_indicator.dart';
import 'package:pov2/data/models/jobList_model.dart';
import 'package:pov2/data/models/trVisitationSchedule_model.dart';
import 'package:pov2/data/services/provider/count_schedule_notifier.dart';
import 'package:pov2/data/services/api/count_service.dart';
import 'package:pov2/data/services/visit_data.dart';
import 'package:pov2/data/services/provider/visitation_notifier.dart';
import 'package:pov2/presentation/widgets/custom_card_job_list.dart';
import 'package:pov2/presentation/widgets/custom_header_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class JobListPage extends ConsumerStatefulWidget {
  const JobListPage({super.key});

  @override
  ConsumerState<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends ConsumerState<JobListPage> {
  // List<JobListModel> listSchedule = [];
  // late SharedPreferences pref;
  // bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async{
    // pref = await SharedPreferences.getInstance();
    // dynamic userId = pref.getString('userId');
    // int cntOnGoing = await CountService.countStatus('OnProgress', userId);
    // int cntWaiting = await CountService.countStatus('Scheduled', userId);
    // int cntFinish = await CountService.countStatus('Completed', userId);
    // setState(() {
    //   onGoingCount = cntOnGoing;
    //   waitingCount = cntWaiting;
    //   finishCount = cntFinish;
    // });

    // List<JobListModel> res = await GetService.getListJob(userId);
    // setState(() {
    //   listSchedule = res  ;
    //   isLoading = false;
    // });

  }
  @override
  Widget build(BuildContext context) {
    var listScheduleAsync = ref.watch(visitationFullProvider);
    var countSchedule = ref.watch(countNotifierProvider);

    final isAnyLoading = listScheduleAsync.isLoading || countSchedule.isLoading;
    final hasError = listScheduleAsync.hasError || countSchedule.hasError;
    var listSchedule = [];

    if(!hasError) {
      listSchedule = listScheduleAsync.value ?? [];
    }
    return CustomNormalScaffold(
        context: context,
        title: Text(
          'Daftar Tugas',
          style: AppText.heading2,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.global),
          child: isAnyLoading ? Center(child: CircularProgressIndicator()) :
              hasError ? CustomProgressIndicator.showInformation(context, 'Gagal mengambil data kunjungan', 'Info') :
              listSchedule.isEmpty ?
              CustomProgressIndicator.showInformation(context, 'Tidak ada tugas kunjungan terdaftar', 'Info') :
                  ListView(
                      children: [
                        CustomHeaderCard(
                            number: countSchedule.value!.waiting.toString(),
                            status: 'Menunggu'
                        ),
                        SizedBox(height: AppSpacing.sm,),
                        CustomHeaderCard(
                            number: countSchedule.value!.onGoing.toString(),
                            status: 'Berlangsung'
                        ),
                        SizedBox(height: AppSpacing.sm,),
                        CustomHeaderCard(
                            number: countSchedule.value!.finish.toString(),
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
                    )
        )
    );
  }
}

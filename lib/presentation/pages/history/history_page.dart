import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_helper.dart';
import 'package:pov2/core/widget/custom_layout.dart';
import 'package:pov2/core/widget/custom_progress_indicator.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';
import 'package:pov2/data/services/visitation_notifier.dart';
import 'package:pov2/presentation/widgets/custom_card_completed_activity.dart';

import '../../../data/models/trVisitationSchedule_model.dart';
import '../../../data/services/get_service.dart';
import '../../../data/services/visit_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  // String name = '';
  // List<TRVisitationScheduleModel> listSchedule = [];
  @override
  void initState() {
    super.initState();
    // _loadListSchedule();
  }

  // Future<void> _loadListSchedule() async{
  //   var pref = await SharedPreferences.getInstance();
  //   List<TRVisitationScheduleModel> res = await GetService.getListCompletedSchedule(pref.getString('userId'));
  //   setState(() {
  //     listSchedule = res  ;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final listScheduleAsync = ref.watch(visitationCompletedProvider);
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
                Expanded(
                  child: listScheduleAsync.when(
                      data: (listSchedule){
                        return ListView.separated(
                          itemBuilder: (BuildContext context, int index){
                            final data = listSchedule[index];
                            return
                              CustomCardCompletedActivity(
                                  place: data.locationName,
                                  date: ParsingHelper.splitTimePre(data.actualStartDateTime),
                                  time: ParsingHelper.splitTimePost(data.actualStartDateTime),
                                  score: '90'
                              );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: AppSpacing.xs);
                          },
                          itemCount: listSchedule.length,
                        );
                      },
                    error: (e, _) => CustomProgressIndicator.showInformation(context, 'Gagal mengambil history', 'Error'),
                    loading: () => const Center(child: CircularProgressIndicator()),
                  )
                ),
              ],
            ),
          )
      ),
    );
  }
}

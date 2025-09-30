import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_helper.dart';
import 'package:pov2/core/widget/custom_layout.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';
import 'package:pov2/presentation/widgets/custom_card_completed_activity.dart';

import '../../../data/models/trVisitationSchedule_model.dart';
import '../../../data/services/get_service.dart';
import '../../../data/services/visit_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String name = '';
  List<TRVisitationScheduleModel> listSchedule = [];
  @override
  void initState() {
    super.initState();
    _loadListSchedule();
  }

  Future<void> _loadListSchedule() async{
    var pref = await SharedPreferences.getInstance();
    List<TRVisitationScheduleModel> res = await GetService.getListCompletedSchedule(pref.getString('userId'));
    setState(() {
      listSchedule = res  ;
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> visitUncompleted = VisitData().taskData.where((task){
      return task['isCompleted'] == true;
    }).toList();

    final data = visitUncompleted[0];
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
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index){
                      final data = listSchedule[index];
                      return
                        CustomCardCompletedActivity(
                            place: GetService.getLocationbyID(data.mtLocationId).then((data)=>data?.name ?? ''),
                            date: ParsingHelper.splitTimePre(data.actualEndDateTime),
                            time: ParsingHelper.splitTimePost(data.actualEndDateTime),
                            score: '90'
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
          )
      ),
    );
  }
}

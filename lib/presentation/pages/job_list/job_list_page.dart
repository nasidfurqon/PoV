import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/data/services/visit_data.dart';
import 'package:pov2/presentation/widgets/custom_card_job_list.dart';
import 'package:pov2/presentation/widgets/custom_header_card.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  List<Map<String, dynamic>> jobList = VisitData().taskData;
  late int onGoingCount = jobList
      .where((item) => item['progress'] == 'Berlangsung')
      .length;
  late int waitingCount = jobList
      .where((item) => item['progress'] == 'Menunggu')
      .length;
  late int finishCount = jobList
      .where((item) => item['progress'] == 'Selesai')
      .length;

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
              ...jobList.asMap().entries.map((entry){
                final index = entry.key;
                final data = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: CustomCardJobList(
                      id: index.toString(),
                      place: data['place'],
                      progress: data['progress'],
                      status: data['status'],
                      deadline: data['deadline'],
                      visitor: data['visitor'],
                      description: data['description']
                  ),
                );
              })
            ],
          ),
        )
    );
  }
}

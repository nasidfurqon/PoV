import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/data/models/report_model.dart';
import 'package:pov2/data/models/trVisitationSchedule_model.dart';
import 'package:pov2/data/services/count_service.dart';
import 'package:pov2/data/services/get_admin_service.dart';
import 'package:pov2/data/services/get_service.dart';
import 'package:pov2/data/services/report_data.dart';
import 'package:pov2/presentation/widgets/custom_card_report.dart';
import 'package:pov2/presentation/widgets/custom_header_card.dart';

import '../../../core/widget/custom_progress_indicator.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // final List<Map<String, dynamic>> reportData = ReportData().report;
  int totalVisit = 0;
  int totalCompleteVisit= 0;
  double percentage = 0.0;
  List<ReportModel> reportData = [];
  bool isLoading= true;
  @override
  void initState(){
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async{
    var temp = await CountService.countAdminTotalVisitation();
    var temp1 = await CountService.countAdminTotalVisitationCompleted();
    var temp3 = (temp1/temp)*100;
    List<ReportModel> temp2 = await GetAdminService.getListReport();
    setState(() {
      totalVisit = temp;
      totalCompleteVisit = temp1;
      percentage = temp3;
      reportData = temp2;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomNormalScaffold(
        context: context,
        title: Text(
          'Laporan',
          style: AppText.heading2,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal:  AppSpacing.global),
          child: isLoading ? Center(child: CircularProgressIndicator(),) : reportData.isEmpty ?
          CustomProgressIndicator.showInformation(context, 'Tidak ada laporan', 'Info'): ListView(
            children: [
              CustomHeaderCard(number: totalVisit.toString(), status: 'Total Kunjungan'),
              SizedBox(height: AppSpacing.sm,),
              CustomHeaderCard(number: '${percentage.toStringAsFixed(2)}%', status: 'Tingkat Kepatuhan'),
              SizedBox(height: AppSpacing.sm,),
              _newReport(),
              SizedBox(height: AppSpacing.sm,),
              ...reportData.asMap().entries.map((entry){
                final index = entry.key;
                final data = entry.value;
                return Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.sm),
                    child: CustomCardReport(id: index, data : data));
              })
            ],
          ),
        )
    );
  }

  Widget _newReport(){
    return CustomCard(
        isBoxShadow: false,
        gradient: LinearGradient(
          colors: [AppColor.primaryTransparent, AppColor.onAccentMedium],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.global),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buat Laporan Baru',
                style: AppText.heading2,
              ),
              SizedBox(height:  AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                        borderSide: BorderSide(
                            color: AppColor.textPrimary,
                            width: 1
                        ),
                        icon: Icons.calendar_month_outlined,
                        iconColor: AppColor.textPrimary,
                        textStyle: AppText.captionPrimary,
                        title: 'Bulanan',
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        onPressed: (){}
                    ),
                  ),
                  SizedBox(width:  AppSpacing.xs),
                  Expanded(
                    child: CustomButton(
                        borderSide: BorderSide(
                          color: AppColor.textPrimary,
                          width: 1
                        ),
                        iconColor: AppColor.textPrimary,
                        icon: Icons.person_outline,
                        textStyle: AppText.captionPrimary,
                        title: 'Performa',
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        onPressed: (){}
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                        borderSide: BorderSide(
                            color: AppColor.textPrimary,
                            width: 1
                        ),
                        icon: Icons.bar_chart_outlined,
                        iconColor: AppColor.textPrimary,
                        textStyle: AppText.captionPrimary,
                        title: 'Analitik',
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        onPressed: (){}
                    ),
                  ),
                  SizedBox(width:  AppSpacing.xs),
                  Expanded(
                    child: CustomButton(
                        borderSide: BorderSide(
                            color: AppColor.textPrimary,
                            width: 1
                        ),
                        iconColor: AppColor.textPrimary,
                        icon: Icons.trending_up,
                        textStyle: AppText.captionPrimary,
                        title: 'Tren',
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        onPressed: (){}
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}

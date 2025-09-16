  import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/data/services/report_data.dart';
import 'package:pov2/presentation/widgets/custom_card_report.dart';
import 'package:pov2/presentation/widgets/custom_header_card.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<Map<String, dynamic>> reportData = ReportData().report;

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
          child: ListView(
            children: [
              CustomHeaderCard(number: '257', status: 'Total Kunjungan'),
              SizedBox(height: AppSpacing.sm,),
              CustomHeaderCard(number: '95%', status: 'Tingkat Kepatuhan'),
              SizedBox(height: AppSpacing.sm,),
              _newReport(),
              SizedBox(height: AppSpacing.sm,),
              ...reportData.asMap().entries.map((entry){
                final index = entry.key;
                final data = entry.value;
                return Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.sm),
                    child: CustomCardReport(id: index,data : data));
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

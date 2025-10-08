import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_helper.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/data/models/report_model.dart';
import 'package:pov2/data/models/trVisitationSchedule_model.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:pov2/presentation/widgets/custom_row_icon.dart';
import 'package:intl/intl.dart';

class CustomCardReport extends StatelessWidget {
  final dynamic id;
  final ReportModel data;
  const CustomCardReport({super.key,required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.global),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Laporan Kunjungan Bulanan",
                      style: AppText.heading3,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(width: AppSpacing.xs,),
                  CustomHighlightDashboard(title: data.progress == true ? 'Completed' : 'Process', fontColor: ParsingColor.cekColor(data.progress == true ? 'Completed' : 'Process')[0], containerColor: ParsingColor.cekColor(data.progress == true ? 'Completed' : 'Process')[1])
                ],
              ),
              SizedBox(height: AppSpacing.sm,),
              CustomRowIcon(
                  icon: Icons.calendar_today_outlined,
                  color: AppColor.textSecondary,
                  title: "Periode: ${DateFormat("MMMM yyyy").format(DateTime(int.parse(data.year!), int.parse(data.month!)))}",
                  textStyle: AppText.caption
              ),
              SizedBox(height: AppSpacing.xs,),
              CustomRowIcon(
                  icon: Icons.bookmark_border,
                  color: AppColor.textSecondary,
                  title: "Dibuat: ${DateFormat('yyyy-MM-dd').format(DateTime(int.parse(data.year!), int.parse(data.month!)))}",
                  textStyle: AppText.caption
              ),
              SizedBox(height: AppSpacing.xs,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${data.totalComplete} Kunjungan',
                    style: AppText.caption,
                  ),
                  Text(
                    '${data.totalLocation} Lokasi',
                    style: AppText.caption,
                  )
                ],
              ),
              if((data.progress == true ? 'Completed' : 'Process') == 'Completed')
              SizedBox(height: AppSpacing.xs,),
              if((data.progress == true ? 'Completed' : 'Process') == 'Completed')
              CustomButtonFull(
                  textStyle: AppText.heading5Tertiary,
                  title: 'Unduh Laporan',
                  backgroundColor: AppColor.primary,
                  padding: EdgeInsets.zero,
                  onPressed: (){},
                  icon: Icons.download_outlined,
                  iconColor: AppColor.textTertiary,
              )
            ],
          ),
        )
    );
  }
}

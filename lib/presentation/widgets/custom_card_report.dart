import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:pov2/presentation/widgets/custom_row_icon.dart';

class CustomCardReport extends StatelessWidget {
  final dynamic id;
  final Map<String, dynamic> data;
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
                      data['name'],
                      style: AppText.heading3,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(width: AppSpacing.xs,),
                  CustomHighlightDashboard(title: data['status'], fontColor: ParsingColor.cekColor(data['status'])[0], containerColor: ParsingColor.cekColor(data['status'])[1])
                ],
              ),
              SizedBox(height: AppSpacing.sm,),
              CustomRowIcon(
                  icon: Icons.calendar_today_outlined,
                  color: AppColor.textSecondary,
                  title: "Periode: ${data['period']}",
                  textStyle: AppText.caption
              ),
              SizedBox(height: AppSpacing.xs,),
              CustomRowIcon(
                  icon: Icons.bookmark_border,
                  color: AppColor.textSecondary,
                  title: "Dibuat: ${data['createdDate']}",
                  textStyle: AppText.caption
              ),
              SizedBox(height: AppSpacing.xs,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${data['totalVisit']} Kunjungan',
                    style: AppText.caption,
                  ),
                  Text(
                    '${data['totalLocation']} Lokasi',
                    style: AppText.caption,
                  )
                ],
              ),
              if(data['status'] == 'Selesai')
              SizedBox(height: AppSpacing.xs,),
              if(data['status'] == 'Selesai')
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

import 'package:flutter/material.dart';
import 'package:pov2/config/router/app_router.dart';
import 'package:pov2/config/router/app_routes.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/data/models/documentation_model.dart';
import 'package:pov2/data/models/trVisitationScheduleEvidence_model.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:pov2/presentation/widgets/custom_row_icon.dart';
import 'package:go_router/go_router.dart';
class CustomCardDocument extends StatelessWidget {
  final dynamic id;
  final DocumentationModel data;

  const CustomCardDocument({super.key, this.id, required this.data});

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
                      '${data.type} Kunjungan ${data.locationName}',
                      style: AppText.heading3,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(width: AppSpacing.xs,),
                  CustomHighlightDashboard(
                      title: '${_cekCount(data.type ?? '', data)} ${data.type ?? ''}',
                      fontColor: ParsingColor.cekColor(
                          data.type ?? '')[0],
                      containerColor: ParsingColor.cekColor(
                          data.type ?? '')[1])
                ],
              ),
              SizedBox(height: AppSpacing.sm,),
              CustomRowIcon(icon: Icons.person_outline,
                  color: AppColor.textSecondary,
                  title: 'Oleh: ${data.fullName}',
                  textStyle: AppText.caption),
              SizedBox(height: AppSpacing.sm,),
              CustomRowIcon(icon: Icons.calendar_today,
                  color: AppColor.textSecondary,
                  title: 'Diunggah: ${data.date}',
                  textStyle: AppText.caption),
              SizedBox(height: AppSpacing.xs,),
              // Text(
              //   data.locationName ?? '',
              //   style: AppText.caption,
              // ),
              // SizedBox(height: AppSpacing.xs,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   data.locationName ?? '',
                  //   style: AppText.caption,
                  // ),
                  Text(
                    data.locationName ?? '',
                    style: AppText.caption,
                  ),
                  // SizedBox(height: AppSpacing.xs,),
                  if(data.type == 'Photo')
                  Text(
                    '${data.totalSizePhoto} MB',
                    style: AppText.caption,
                  ),
                  if(data.type == 'Document')
                    Text(
                      '${data.totalSizeDocument} MB',
                      style: AppText.caption,
                    ),
                  if(data.type == 'Video')
                    Text(
                      '${data.totalSizeVideo} MB',
                      style: AppText.caption,
                    )
                ],
              ),
              SizedBox(height: AppSpacing.xs,),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      borderSide: BorderSide(
                          color: AppColor.textPrimary,
                          width: 1
                      ),
                      textStyle: AppText.heading5,
                      title: 'Lihat',
                      backgroundColor: AppColor.background,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        context.pushNamed(AppRoutes.documentationDetail.name, pathParameters: {
                          "ID": data.scheduleId.toString(),
                          "type": data.type.toString()
                        });
                      },
                      icon: Icons.remove_red_eye_outlined,
                      iconColor: AppColor.textPrimary,
                    ),
                  ),
                  SizedBox(width: AppSpacing.xs,),
                  Expanded(
                    child: CustomButton(
                      textStyle: AppText.heading5Tertiary,
                      title: 'Unduh',
                      backgroundColor: AppColor.primary,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icons.download_outlined,
                      iconColor: AppColor.textTertiary,
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
  
  String _cekCount(String type, DocumentationModel data){
    if(type == 'Photo'){
      return data.countPhoto!;
    }
    else if(type == 'Document'){
      return data.countDocument!;
    }
    else if(type == 'Video'){
      return data.countVideo!;
    }
    else{
      return '';
    }
  }
}
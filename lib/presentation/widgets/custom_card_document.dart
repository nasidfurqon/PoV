import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:pov2/presentation/widgets/custom_row_icon.dart';

class CustomCardDocument extends StatelessWidget {
  final dynamic id;
  final Map<String, dynamic> data;
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
                      data['name'],
                      style: AppText.heading3,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(width: AppSpacing.xs,),
                  CustomHighlightDashboard(title: data['type'], fontColor: ParsingColor.cekColor(data['type'])[0], containerColor: ParsingColor.cekColor(data['type'])[1])
                ],
              ),
              SizedBox(height: AppSpacing.sm,),
              CustomRowIcon(icon: Icons.calendar_today, color: AppColor.textSecondary, title: 'Diunggah: ${data['uploadedDate']}', textStyle: AppText.caption),
              SizedBox(height: AppSpacing.xs,),
              Text(
                data['place'],
                style: AppText.caption,
              ),
              SizedBox(height: AppSpacing.xs,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['description'],
                    style: AppText.caption,
                  ),
                  Text(
                    '${data['Size']} MB',
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
                        onPressed: (){},
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
                      onPressed: (){},
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
}

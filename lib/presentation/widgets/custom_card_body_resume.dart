import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';

class CustomCardBodyResume extends StatelessWidget {
  final dynamic id;
  final Map<String, dynamic> data;
  final bool? isNewActivity;
  const CustomCardBodyResume({super.key, this.isNewActivity = false, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['place'],
                    style: AppText.heading5,
                  ),
                  if(isNewActivity == false)
                  Text(
                    '${data['person']} \u2022 ${data['hourFrom']}',
                    style: AppText.caption,
                  ),
                  if(isNewActivity == true)
                    Text(
                        '${data['person']} \u2022 ${data['deadline']}',
                      style: AppText.caption,
                    )
                ],
              ),
              SizedBox(width: AppSpacing.xs,),
              Column(
                children: [
                  if(isNewActivity == true)
                    CustomHighlightDashboard(
                        title: '${data['score']}/100',
                        fontColor: ParsingColor.cekColor('score')[0],
                        containerColor:  ParsingColor.cekColor('score')[1]
                    ),
                  if(isNewActivity == true)
                    SizedBox(height: AppSpacing.xs,),
                  CustomHighlightDashboard(
                      title: data['statusJadwal'],
                      fontColor: ParsingColor.cekColor(data['statusJadwal'])[0],
                      containerColor:  ParsingColor.cekColor(data['statusJadwal'])[1]
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}

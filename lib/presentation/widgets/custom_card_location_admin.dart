import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:pov2/presentation/widgets/custom_row_icon.dart';

class CustomCardLocationAdmin extends StatelessWidget {
  final dynamic id;
  final Map<String, dynamic> data;
  const CustomCardLocationAdmin({super.key, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.global),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['place'],
                style: AppText.heading3,
              ),
              SizedBox(height: AppSpacing.xxs),
              Text(
                data['type'],
                style: AppText.caption,
              ),
              Divider(),
              SizedBox(height: AppSpacing.xs),
              Text(
                '${data['street']}, ${data['city']}',
                style: AppText.caption,
              ),
              SizedBox(height: AppSpacing.xs),
              CustomRowIcon(
                  icon: Icons.location_on_outlined,
                  color: AppColor.accentCompletion,
                  title: data['location'],
                  textStyle: AppText.caption
              ),
              SizedBox(height: AppSpacing.xs),
              CustomHighlightDashboard(
                  title: 'Geofence: ${data['geofence']}m',
                  fontColor: AppColor.accentCompletion,
                  containerColor: AppColor.onAccentCompletion
              ),
              SizedBox(height: AppSpacing.xs),
              CustomHighlightDashboard(
                  title: 'QR: ${data['code']}',
                  fontColor: AppColor.accentMedium,
                  containerColor: AppColor.onAccentMedium
              ),
            ],
          ),
        )
    );
  }
}

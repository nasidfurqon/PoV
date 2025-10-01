import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/data/models/mtLocation_model.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:pov2/presentation/widgets/custom_row_icon.dart';

class CustomCardLocationAdmin extends StatelessWidget {
  final dynamic id;
  final MTLocationModel data;
  const CustomCardLocationAdmin({super.key, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.onAccentCompletion,
            AppColor.onAccentCompletion.withOpacity(0.4),
            AppColor.onAccentCompletion.withOpacity(0.1),
            Colors.transparent,
          ],
          stops: const [0.0, 0.1, 0.2, 0.3],
        ),
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.global),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name ?? '',
                style: AppText.heading3,
              ),
              SizedBox(height: AppSpacing.xxs),
              Text(
                (data.mtLocationTypeId ?? '').toString(),
                style: AppText.caption,
              ),
              Divider(),
              SizedBox(height: AppSpacing.xs),
              Text(
                '${data.address}',
                style: AppText.caption,
              ),
              SizedBox(height: AppSpacing.xs),
              CustomRowIcon(
                  icon: Icons.location_on_outlined,
                  color: AppColor.accentCompletion,
                  title: '${data.latitude}, ${data.longitude}',
                  textStyle: AppText.caption
              ),
              SizedBox(height: AppSpacing.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomHighlightDashboard(
                      title: 'Geofence: ${data.geoFence}m',
                      fontColor: AppColor.accentCompletion,
                      containerColor: AppColor.onAccentCompletion
                  ),
                  SizedBox(width: AppSpacing.xs),
                  CustomHighlightDashboard(
                      title: 'Code: ${data.plantCode}',
                      fontColor: AppColor.accentMedium,
                      containerColor: AppColor.onAccentMedium
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}

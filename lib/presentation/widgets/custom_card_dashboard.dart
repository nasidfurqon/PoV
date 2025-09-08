import 'package:flutter/material.dart';
import 'package:pov2/config/router/app_routes.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:go_router/go_router.dart';
class CustomCardDashboard extends StatelessWidget {
  final String place;
  final String status;
  final String street;
  final String city;
  final String hourfrom;
  final String hourTo;
  final String radius;
  final String description;
  final dynamic id;
  const CustomCardDashboard({
    super.key,
    required this.place,
    required this.status,
    required this.street,
    required this.city,
    required this.hourfrom,
    required this.hourTo,
    required this.radius,
    required this.description,
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(place, style: AppText.heading3),
                CustomHighlightDashboard(title: status, fontColor: _cekColor(status)[0], containerColor: _cekColor(status)[1])
              ],
            ),
            SizedBox(height: AppSpacing.sm,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$street, $city', style: AppText.caption),
                CustomHighlightDashboard(title: 'scheduled', fontColor: AppColor.textPrimary, containerColor: AppColor.border)

              ],
            ),
            SizedBox(height: AppSpacing.sm,),
            Row(
              children: [
                Icon(Icons.watch_later_outlined, color: AppColor.textSecondary,),
                SizedBox(width: 2,),
                Text('$hourfrom - $hourTo', style: AppText.caption),
                SizedBox(width: AppSpacing.md,),
                Icon(Icons.location_on_outlined, color: AppColor.textSecondary,),
                Text('${radius}m radius', style: AppText.caption)
              ],
            ),
            SizedBox(height: AppSpacing.sm,),
            Text(description, style: AppText.caption,),
            SizedBox(height: AppSpacing.sm,),
            CustomButtonFull(
              icon: Icons.check_circle_outline,
              textStyle: AppText.heading3Secondary,
              title: 'Start Visit',
              backgroundColor: AppColor.primary,
              padding: EdgeInsets.all(2),
              onPressed: () {
                context.pushNamed(AppRoutes.visit.name, pathParameters: {
                  'id': id.toString()
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _cekColor(String status) {
    if (status == 'high') {
      return [AppColor.accentHigh, AppColor.onAccentHigh];
    } else if (status == 'normal') {
      return [AppColor.accentMedium, AppColor.onAccentMedium];
    } else {
      return [AppColor.accentCompleted, AppColor.onAccentCompleted];
    }
  }
}

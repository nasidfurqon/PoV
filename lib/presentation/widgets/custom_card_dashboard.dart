import 'package:flutter/material.dart';
import 'package:pov2/config/router/app_routes.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/parsing_status_color.dart';
class CustomCardDashboard extends StatelessWidget {
  final dynamic place;
  final String status;
  final dynamic street;
  final String? city;
  final String hourfrom;
  final String priority;
  final String hourTo;
  final String radius;
  final String description;
  final dynamic id;
  const CustomCardDashboard({
    super.key,
    required this.place,
    required this.priority,
    required this.status,
    required this.street,
     this.city,
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
                place is Future<String> ?
                FutureBuilder<String?>(
                  future: place as Future<String>,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("...");
                    } else if (snapshot.hasError) {
                      return const Text('');
                    } else {
                      return Text(
                        snapshot.data!,
                        style: AppText.heading3,
                      );
                    }
                  },) :
                Text(place, style: AppText.heading3),
                CustomHighlightDashboard(title: priority, fontColor: ParsingColor.cekColor(priority)[0], containerColor: ParsingColor.cekColor(priority)[1])
              ],
            ),
            SizedBox(height: AppSpacing.sm,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                street is Future<String> ?
                FutureBuilder<String?>(
                  future: street as Future<String>,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("...");
                    } else if (snapshot.hasError) {
                      return const Text('');
                    } else {
                      return Text(
                        snapshot.data!,
                        style: AppText.caption,
                      );
                    }
                  },) :
                Text('$street, $city', style: AppText.caption),
                CustomHighlightDashboard(title: status, fontColor: ParsingColor.cekColor(status)[0], containerColor: ParsingColor.cekColor(status)[1])

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
              textStyle: AppText.heading3Tertiary,
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
}

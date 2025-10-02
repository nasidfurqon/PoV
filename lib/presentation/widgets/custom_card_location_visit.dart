import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/location.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/data/models/mtLocationType_model.dart';
import 'package:pov2/data/models/mtLocation_model.dart';
import 'package:pov2/data/services/get_service.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:pov2/presentation/widgets/custom_row_icon.dart';

class CustomCardLocationVisit extends StatelessWidget {
  final String id;
  final MTLocationModel? data;
  const CustomCardLocationVisit({super.key,required this.id, required this.data});

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
                  Text(
                    data?.name ?? '',
                    style: AppText.heading3,
                  ),
                  CustomHighlightDashboard(title: data?.isActive == true ?  'Aktif' : 'Maintenance', fontColor: ParsingColor.cekColor(data?.isActive == true ?  'Aktif' : 'Maintenance')[0], containerColor: ParsingColor.cekColor(data?.isActive == true ?  'Aktif' : 'Maintenance')[1]),
                ],
              ),
              SizedBox(height: AppSpacing.xs),
              CustomRowIcon(icon: Icons.location_on_outlined, color: AppColor.textSecondary, title: '${data?.address}', textStyle: AppText.caption),
              SizedBox(height: AppSpacing.xs),
              CustomRowIcon(icon: Icons.shield_outlined, color: AppColor.textSecondary, title: 'Radius Geofence: ${data?.geoFence}', textStyle: AppText.caption),
              SizedBox(height: AppSpacing.xs),
              CustomRowIcon(icon: Icons.watch_later_outlined, color: AppColor.textSecondary, title: 'Kunjungan Terakhir: -', textStyle: AppText.caption),
              SizedBox(height: AppSpacing.xs),
              FutureBuilder<MTLocationTypeModel?>(
                future: GetService.getLocationType(data?.mtLocationTypeId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("...");
                  } else if (snapshot.hasError) {
                    return const Text('');
                  } else {
                    return Text(
                      snapshot.data!.name ?? '',
                      style: AppText.caption,

                    );
                  }
                },),
              SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                        borderSide: BorderSide(
                          color: AppColor.textPrimary,
                          width: 1
                        ),
                        textStyle: AppText.captionPrimary,
                        iconColor: AppColor.textPrimary,
                        title: 'Navigasi',
                        icon: Icons.navigation_outlined,
                        backgroundColor: AppColor.background,
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          final lat = double.parse(data?.latitude ?? '0');
                          final long = double.parse(data?.longitude ?? '0');
                          LocationHelper.openLocation(lat, long);
                        }
                    ),
                  ),
                  // if(data['statusVisit'] == 'Aktif')
                  // SizedBox(width: AppSpacing.xs,),
                  // if(data['statusVisit'] == 'Aktif')
                  //   Expanded(
                  //     child: CustomButton(
                  //         textStyle: AppText.captionTertiary,
                  //         title: 'Kunjungi',
                  //         backgroundColor: AppColor.primary,
                  //         padding: EdgeInsets.zero,
                  //         onPressed: (){}
                  //     ),
                  //   ),
                ],
              )
            ],
          ),
        )
    );
  }
}

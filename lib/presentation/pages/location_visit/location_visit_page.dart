import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/data/services/visit_data.dart';
import 'package:pov2/presentation/widgets/custom_card_location_visit.dart';

import '../../widgets/custom_header_card.dart';

class LocationVisitPage extends StatefulWidget {
  const LocationVisitPage({super.key});

  @override
  State<LocationVisitPage> createState() => _LocationVisitPageState();
}

class _LocationVisitPageState extends State<LocationVisitPage> {
  List<Map<String, dynamic>> dataList = VisitData().taskData;
  @override
  Widget build(BuildContext context) {
    return CustomNormalScaffold(
        context: context,
        title: Text(
          'Lokasi Kunjungan',
          style: AppText.heading2,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.global),
          child: ListView(
            children: [
              CustomHeaderCard(
                  number: '1',
                  status: 'Total Lokasi'
              ),
              SizedBox(height: AppSpacing.sm,),
              CustomHeaderCard(
                  number: '1',
                  status: 'Aktif'
              ),
              SizedBox(height: AppSpacing.sm,),
              ...dataList.asMap().entries.map((entry){
                final index = entry.key;
                final data = entry.value;
                return Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.sm),
                    child: CustomCardLocationVisit(id: index.toString(), data: data)
                );
              })
            ],
          ),
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/data/models/mtLocation_model.dart';
import 'package:pov2/data/services/count_service.dart';
import 'package:pov2/data/services/get_service.dart';
import 'package:pov2/data/services/location_notifier.dart';
import 'package:pov2/data/services/visit_data.dart';
import 'package:pov2/presentation/widgets/custom_card_location_visit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/widget/custom_progress_indicator.dart';
import '../../widgets/custom_header_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class LocationVisitPage extends ConsumerStatefulWidget {
  const LocationVisitPage({super.key});

  @override
  ConsumerState<LocationVisitPage> createState() => _LocationVisitPageState();
}

class _LocationVisitPageState extends ConsumerState<LocationVisitPage> {
  int activeCount = 0;
  int totCount = 0;
  late SharedPreferences pref;
  // List<MTLocationModel?> listLocation = [];
  // bool isLoading = true;
  @override
  void initState(){
    super.initState();
    // _loadListLocation();
    // _loadCountData();
  }

  // Future<void> _loadCountData() async{
  //   pref = await SharedPreferences.getInstance();
  //   int cntActive = await CountService.countActiveLocation(pref.getString('userId'));
  //   int cnt = await  CountService.countLocation(pref.getString('userId'));
  //   setState(() {
  //     activeCount = cntActive;
  //     totCount = cnt;
  //     // isLoading = false;
  //   });
  // }

  // Future<void> _loadListLocation() async{
  //   List<MTLocationModel?> listLoc = await GetService.getListLocation();
  //   setState(() {
  //     listLocation = listLoc;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    var listLocationAsync = ref.watch(locationProvider);
    return CustomNormalScaffold(
        context: context,
        title: Text(
          'Lokasi Kunjungan',
          style: AppText.heading2,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.global),
          child: listLocationAsync.when(
              data: (listLocation){
                if(listLocation.isEmpty){
                  CustomProgressIndicator.showInformation(context, 'Tidak ada lokasi terdaftar', 'Info');
                }
                return ListView(
                  children: [
                    CustomHeaderCard(
                        number: totCount.toString(),
                        status: 'Total Lokasi'
                    ),
                    SizedBox(height: AppSpacing.sm,),
                    CustomHeaderCard(
                        number: activeCount.toString(),
                        status: 'Aktif'
                    ),
                    SizedBox(height: AppSpacing.sm,),
                    ...listLocation.asMap().entries.map((entry){
                      final index = entry.key;
                      final data = entry.value;
                      return Padding(
                          padding: EdgeInsets.only(bottom: AppSpacing.sm),
                          child: CustomCardLocationVisit(id: index.toString(), data: data)
                      );
                    })
                  ],
                );
              },
              error: (e, _) => CustomProgressIndicator.showInformation(context, 'Gagal mengambil lokasi', 'Info'),
              loading: () => Center(child: CircularProgressIndicator(),)
          )

        )
    );
  }
}

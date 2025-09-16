import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/data/services/visit_data.dart';
import 'package:pov2/presentation/widgets/custom_card_body_resume.dart';
import 'package:pov2/presentation/widgets/custom_card_header_resume.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  final List<Map<String, dynamic>> visitData = VisitData().taskData;
  @override
  Widget build(BuildContext context) {
    return CustomNormalScaffold(
        context: context,
        title: Text(
          'Dashboard Administrator',
          style: AppText.heading2,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.global),
          child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: TabBar(
                      tabAlignment: TabAlignment.start,
                        indicatorColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        labelColor: Colors.white,
                        labelStyle: AppText.heading5,
                        indicator: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        indicatorPadding: const EdgeInsets.all(AppSpacing.xxs),
                        indicatorSize: TabBarIndicatorSize.tab,
                        isScrollable: true,
                        tabs: const <Widget>[
                          Tab(
                            text: 'Ringkasan',
                          ),
                          Tab(
                            text: 'Jadwal Kunjungan',
                          ),
                          Tab(
                            text: 'Lokasi',
                          ),
                          Tab(
                            text: 'Pengguna',
                          ),
                        ]
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _resume(),
                        Center(child: Text("Lokasi")),
                        Center(child: Text("Lokasi")),
                        Center(child: Text("Pengguna")),
                      ],
                    ),
                  )
                ],
              )
          ),
        )
    );
  }

  Widget _resume(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: AppSpacing.sm,),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: CustomCardHeaderResume(
                      title: 'Total Pengguna',
                      icon: Icons.person_outline,
                      color: AppColor.accentMedium,
                      number: '4',
                      description: 'Petugas lapangan aktif'
                  ),
                ),
                SizedBox(width: AppSpacing.xs,),
                Expanded(
                  child: CustomCardHeaderResume(
                      title: 'Lokasi',
                      icon: Icons.location_on_outlined,
                      color: AppColor.accentCompleted,
                      number: '2',
                      description: 'Situs Terdaftar'
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: CustomCardHeaderResume(
                    title: 'Kunjungan Hari Ini',
                    icon: Icons.date_range_rounded,
                    color: AppColor.accentCompletion,
                    number: '1/2',
                    description: 'Selesai/Terjadwal'
                ),
              ),
              SizedBox(width: AppSpacing.xs,),
              Expanded(
                child: CustomCardHeaderResume(
                    title: 'Rata-rata Skor PoV',
                    icon: Icons.trending_up,
                    color: AppColor.accentHigh,
                    number: '92/100',
                    description: 'Bulan ini'
                ),
              )
            ],
          ),
          SizedBox(height:  AppSpacing.sm),
          _resume_schedule(),
          SizedBox(height:  AppSpacing.sm),
          _resume_new(),
          SizedBox(height:  AppSpacing.sm),
        ],
      ),
    );
  }

  Widget _resume_schedule(){
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.global),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jadwal Hari Ini',
                style: AppText.heading4,
              ),
              Text(
                'Penugasan kunjungan saat ini',
                style: AppText.caption,
              ),
              Divider(),
              SizedBox(
                height: 200,
                child: ListView(
                  children: [
                    ...visitData.asMap().entries.map((entry){
                      final data = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: CustomCardBodyResume(id: entry.key, data: data),
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  Widget _resume_new(){
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.global),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aktifitas Terbaru',
                style: AppText.heading4,
              ),
              Text(
                'Penyelesaian Kunjungan Terkini',
                style: AppText.caption,
              ),
              Divider(),
              SizedBox(
                height: 200,
                child: ListView(
                  children: [
                    ...visitData.asMap().entries.map((entry){
                      final data = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: CustomCardBodyResume(id: entry.key, data: data, isNewActivity: true,),
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}

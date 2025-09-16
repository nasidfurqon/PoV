import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
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
                        ]),
                  ),
                ],
              )
          ),
        )
    );
  }
}

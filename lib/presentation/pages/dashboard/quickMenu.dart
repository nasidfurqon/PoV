import 'package:flutter/material.dart';
import 'package:pov2/config/router/route_path.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:go_router/go_router.dart';
import '../../../config/router/app_routes.dart';
import '../../../config/theme/app_color.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_theme.dart';
import '../../../config/theme/app_text.dart';
import '../../../data/models/dashboard_model.dart';
import 'package:go_router/go_router.dart';

class QuickMenu extends StatefulWidget {
  final String status;
  final List<MenuGroupModel> menuItems;

  QuickMenu({
    Key? key,
    List<MenuGroupModel>? menuItems, required this.status,
  })  : menuItems = menuItems ?? MenuGroupModel.generateMenu(),
        super(key: key);

  @override
  State<QuickMenu> createState() => _QuickMenuState();
}

class _QuickMenuState extends State<QuickMenu> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
        color: Colors.white,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            SizedBox(height: AppSpacing.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 110,
                    child: _quickMenuItem()
                )
              ],
            ),
          ],
        ),
      );
  }

  ListView _quickMenuItem(){
    List<Map<String, dynamic>> menu = [
      {
        "label": "Daftar Tugas",
        "icon": Icons.checklist_rtl_outlined,
        "routes": () => context.pushNamed(AppRoutes.jobList.name)
      },
      {
        "label": "Lokasi Kunjungan",
        "icon": Icons.location_on_outlined,
        "routes": () => context.pushNamed(AppRoutes.locationVisit.name)
      },
      {
        "label": "Laporan",
        "icon": Icons.bar_chart,
        "routes": () => context.pushNamed(AppRoutes.report.name)
      },
      {
        "label": "Admin Panel",
        "icon": Icons.admin_panel_settings,
        "routes": (){}
      },
      {
        "label": "Dokumentasi",
        "icon": Icons.document_scanner_outlined,
        "routes": () => context.pushNamed(AppRoutes.documentation.name)
      },
    ];
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: menu.length,
        itemBuilder: (BuildContext context, int index){
          final data = menu[index];
          return  SizedBox(
            width:70,
            child: MenuItem(
              label: data['label'],
              icon:Icon(data['icon'],
                  size: 34, color: AppColor.primary
              ),
              onTap: data['routes']
            ),
          );
        }
    );
  }
}


class MenuItem extends StatelessWidget {
  final String? status;
  final String label;
  final Icon? icon;
  final Function? onTap;
  final Widget? route;

  const MenuItem({
    Key? key,
    required this.label,
    this.icon,
    this.onTap,
    this.route, this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap?.call(),
        child: _buildMenuItemContent()
    );
  }

  Widget _buildMenuItemContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomCard(
          isBoxShadow: false,
          color: AppColor.primaryTransparent,
          padding: EdgeInsets.all(AppSpacing.xs),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xs),
            child: icon!,
          )
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 32,
          child: Text(
            label,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: AppText.caption2
          ),
        )
      ],
    );
  }
}

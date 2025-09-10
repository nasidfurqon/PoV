import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';

class MenuItemModel {
  final String label;
  final Icon icon;
  final String? iconPath;
  final Function? onTap;
  final Widget? route;

  MenuItemModel(
      {required this.label,
        required this.icon,
        this.onTap,
        this.iconPath,
        this.route});
}

class MenuGroupModel {
  final String title;
  final List<MenuItemModel> items;
  final bool isExpanded;

  const MenuGroupModel({
    required this.title,
    required this.items,
    this.isExpanded = false,
  });

  static List<MenuGroupModel> generateMenu() {
    return [
      MenuGroupModel(title: 'Quick Menu', items: [
        MenuItemModel(
            label: 'Daftar Tugas',
            icon: const Icon(Icons.checklist_rtl_outlined,
                size: 34, color: AppColor.primary),
            route: null),
        MenuItemModel(
            label: 'Lokasi Kunjungan',
            icon: const Icon(Icons.location_on_outlined,
                size: 34, color: AppColor.primary),
            route: null),
        MenuItemModel(
            label: 'Laporan',
            icon: const Icon(Icons.bar_chart,
                size: 36, color: AppColor.primary),
            route: null),
        MenuItemModel(
            label: 'Admin Panel',
            icon: const Icon(Icons.admin_panel_settings,
                size: 36, color: AppColor.primary),
            route: null),
        MenuItemModel(
            label: 'Dokumentasi',
            icon: const Icon(Icons.document_scanner_outlined,
                size: 36, color: AppColor.primary),
            route: null),
        MenuItemModel(
            label: 'Change Manning Agent',
            icon: const Icon(Icons.directions_boat,
                size: 36, color: AppColor.primary),
            route: null),
      ]),
    ];
  }
}

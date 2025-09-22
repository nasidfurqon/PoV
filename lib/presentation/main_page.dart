import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/presentation/pages/dashboard/dashboardPage.dart';
import 'package:pov2/presentation/pages/dashboardFieldOperations/dashboard_field_operations_page.dart';
import 'package:pov2/presentation/pages/history/history_page.dart';
import 'package:pov2/presentation/pages/profile/profile_page.dart';
import 'package:pov2/presentation/provider/bottom_nav_notifier.dart';
import '../config/theme/app_spacing.dart';
import '../config/theme/app_color.dart';

class MainPage extends ConsumerStatefulWidget {
  final String user;
  const MainPage({super.key, required this.user});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bottomNav = ref.watch(bottomNavNotifier);

    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        fit: StackFit.loose,
        clipBehavior: Clip.hardEdge,
        children: [
          Padding(
            padding:  EdgeInsets.zero,
            child: PageView(
              controller: bottomNav.controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                if(widget.user == 'Administrator')
                DashboardPage(),
                if(widget.user == 'FO')
                  DashboardFieldOfficerPage(),
                HistoryPage(),
                ProfilePage()
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomCard(
              borderRadius: 0,
              padding: EdgeInsets.zero,
              height: kBottomNavigationBarHeight + AppSpacing.xs,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: BottomNavigationBar(
                  elevation: 0,
                  onTap: (index) {
                    bottomNav.changeIndex(index);
                  },
                  currentIndex: bottomNav.index,
                  backgroundColor: Colors.transparent,
                  selectedItemColor: AppColor.primary,
                  unselectedItemColor: AppColor.textSecondary,
                  selectedLabelStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColor.primary,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColor.textSecondary,
                  ),
                  selectedIconTheme: const IconThemeData(
                    size: 28,
                  ),
                  unselectedIconTheme: const IconThemeData(
                    size: 28,
                  ),
                  showUnselectedLabels: true,
                  showSelectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.home_filled), label: 'Home'),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.history_rounded), label: 'History'),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.person), label: 'Profile'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

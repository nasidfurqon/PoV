import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pov2/config/router/app_routes.dart';
import 'package:pov2/config/router/route_path.dart';
import 'package:pov2/presentation/main_page.dart';
import 'package:pov2/presentation/pages/auth/loginPage.dart';
import 'package:pov2/presentation/pages/dashboard/dashboardPage.dart';
import 'package:pov2/presentation/pages/job_list/job_list_page.dart';
import 'package:pov2/presentation/pages/location_visit/location_visit_page.dart';
import 'package:pov2/presentation/pages/report/report_page.dart';
import 'package:pov2/presentation/pages/shimmer/splashPage.dart';
import 'package:pov2/presentation/pages/visit_progres/visitProgresPage.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RoutePath.splash,
  routes: [
    GoRoute(
      path: RoutePath.splash,
      name: AppRoutes.splash.name,
      builder: (context, state) => SplashPage()
    ),
    GoRoute(
      path: RoutePath.login,
      name: AppRoutes.login.name,
      builder: (context, state) => LoginPage()
    ),
    GoRoute(
      path: RoutePath.dashboard,
      name: AppRoutes.dashboard.name,
      builder: (context, state) =>  DashboardPage()
    ),
    GoRoute(
      path: RoutePath.visit,
      name: AppRoutes.visit.name,
      builder: (context, state) {
        final String? id = state.pathParameters['id'];
        return VisitProgressPage(id: id);
      }
    ),
    GoRoute(
      path: RoutePath.home,
      name: AppRoutes.home.name,
      builder: (context, state) => MainPage()
    ),
    GoRoute(
      path: RoutePath.jobList,
      name: AppRoutes.jobList.name,
      builder: (context, state) => JobListPage()
    ),
    GoRoute(
      path: RoutePath.locationVisit,
      name: AppRoutes.locationVisit.name,
      builder: (context, state) => LocationVisitPage()
    ),
    GoRoute(
      path: RoutePath.report,
      name: AppRoutes.report.name,
      builder: (context, state) => ReportPage()
    )
  ]
);  
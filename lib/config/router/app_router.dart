import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pov2/config/router/app_routes.dart';
import 'package:pov2/config/router/route_path.dart';
import 'package:pov2/presentation/pages/auth/loginPage.dart';
import 'package:pov2/presentation/pages/dashboard/dashboardPage.dart';
import 'package:pov2/presentation/pages/shimmer/splashPage.dart';

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
      builder: (context, state) =>  Dashboardpage()
    )
  ]
);  
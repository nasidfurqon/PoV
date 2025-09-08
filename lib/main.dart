import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_theme.dart';
import 'package:pov2/presentation/pages/shimmer/splashPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoV',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashPage()
    );
  }
}
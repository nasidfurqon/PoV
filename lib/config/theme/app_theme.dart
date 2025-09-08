import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
      useMaterial3: true,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColor.background,
      primaryColor: AppColor.primary,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.primary,
        elevation: 0,
        toolbarHeight: 64,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: AppText.heading2,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.background,
        contentPadding: EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.md),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: BorderSide(color: AppColor.border)
        ),
        focusedBorder: OutlineInputBorder( 
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: AppColor.primary, width: 1.5)
        ),
        hintStyle: AppText.caption,
      ),  

      textTheme: const TextTheme(
        headlineLarge: AppText.heading1,
        headlineMedium: AppText.heading2,
        headlineSmall: AppText.heading3,
        bodyMedium: AppText.body,
        bodySmall: AppText.caption,
      ),
    );
  }
}
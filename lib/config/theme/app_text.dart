import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';

class AppText {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24, 
    fontWeight: FontWeight.bold,
    color: AppColor.textPrimary
  );
  
  static const TextStyle headingPrimary = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColor.primary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColor.textPrimary
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColor.textPrimary,
  );

  static const TextStyle heading3Secondary = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColor.textTertiary,
    );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColor.textPrimary
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColor.textSecondary
  );
}

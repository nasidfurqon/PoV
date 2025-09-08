import 'package:flutter/material.dart';
import 'package:pov2/config/router/app_routes.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      context.goNamed(AppRoutes.login.name);
    });
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppSpacing.xxl ,),
            const Text(
              'Proof-of-Visit',
              style: TextStyle(
                color: AppColor.textTertiary,
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.xxl),
            Column(
              children: [
                Text('presented by:', style: AppText.heading3Secondary,),
                Image.asset('assets/patra-tanpa-bg.png', height: 150, color: AppColor.textTertiary,),
              ],
            ),
            SizedBox(height: AppSpacing.md),
             const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColor.textTertiary),
            ),

          ],
        ),
      ),
    );
  }
}

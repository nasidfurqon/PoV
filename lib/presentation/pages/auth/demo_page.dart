import 'package:flutter/material.dart';
import 'package:pov2/core/widget/custom_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../config/router/app_routes.dart';
import '../../../config/theme/app_color.dart';
import '../../../config/theme/app_spacing.dart';
import '../../../config/theme/app_text.dart';
import '../../../core/widget/custom_button.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAuth(
      child: Column(
        children: [
          CustomButton(
            textStyle: AppText.captionPrimary,
            title: 'Kembali ke Login Biasa',
            backgroundColor: AppColor.border,
            foregroundColor: AppColor.textPrimary,
            padding: EdgeInsets.symmetric(
              vertical: AppSpacing.xs,
              horizontal: AppSpacing.sm,
            ),
            onPressed: () {
              context.pushNamed(AppRoutes.login.name);
            },
          ),
          Padding(
            padding: EdgeInsets.all(AppSpacing.global),
            child: Column(
              children: [
                Text(
                  'Klik tombol dibawah untuk langsung mengakses sistem:',
                  style: AppText.caption,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.xs),
                CustomButtonFull(
                    textStyle: AppText.heading4Tertiary,
                    title: 'Masuk sebagai Administrator',
                    icon: Icons.settings,
                    iconColor: AppColor.textTertiary,
                    backgroundColor: AppColor.primary,
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      context.goNamed(AppRoutes.home.name, pathParameters: {
                        'user': 'Administrator'
                      });
                    }
                ),
                CustomButtonFull(
                    textStyle: AppText.heading4Tertiary,
                    title: 'Masuk sebagai Petugas Lapangan',
                    icon: Icons.person_outline,
                    iconColor: AppColor.textTertiary,
                    backgroundColor: AppColor.accentHigh,
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      context.goNamed(AppRoutes.home.name, pathParameters: {
                        'user': 'FO'
                      });
                    }
                ),
                CustomButtonFull(
                    textStyle: AppText.heading4Tertiary,
                    title: 'Masuk sebagai Supervisor',
                    icon: Icons.person_search_outlined,
                    iconColor: AppColor.textTertiary,
                    backgroundColor: AppColor.textPrimary,
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      context.goNamed(AppRoutes.home.name, pathParameters: {
                        'user': 'Supervisor'
                      });
                    }
                ),
                SizedBox(
                  height: AppSpacing.sm,
                ),
                Text(
                  'Akun demo melewati persyaratan SMTP dan bekerja langsung',
                  style: AppText.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

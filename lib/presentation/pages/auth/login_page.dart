import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:pov2/config/router/app_routes.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_auth.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_layout.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';
import 'package:pov2/core/widget/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return CustomAuth(
      child: Column(
        children: [
          CustomButton(
            textStyle: AppText.captionPrimary,
            title: 'Coba mode demo',
            backgroundColor: AppColor.border,
            foregroundColor: AppColor.textPrimary,
            padding: EdgeInsets.symmetric(
              vertical: AppSpacing.xs,
              horizontal: AppSpacing.sm,
            ),
            onPressed: () {
              context.pushNamed(AppRoutes.demo.name);
            },
          ),
          Padding(
            padding: EdgeInsets.all(AppSpacing.global),
            child: Column(
              children: [
                CustomTextFieldWithLabel(
                  keyboardType: TextInputType.emailAddress,
                  label: "Email",
                  hint: "anda@pertamina.com",
                ),
                SizedBox(height: AppSpacing.md),
                CustomTextFieldWithLabel(
                  keyboardType: TextInputType.visiblePassword,
                  label: "Password",
                  hint: "***",
                  obscureText: true,
                ),
                SizedBox(height: AppSpacing.md),
                CustomButtonFull(
                  textStyle: AppText.heading3Tertiary,
                  title: 'Masuk',
                  backgroundColor: AppColor.primary,
                  padding: EdgeInsets.symmetric(
                    vertical: AppSpacing.xs,
                    horizontal: AppSpacing.md,
                  ),
                  onPressed: () {},
                ),
                SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Butuh akun? '),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

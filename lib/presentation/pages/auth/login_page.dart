import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:pov2/config/router/app_routes.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/fingerprint_helper.dart';
import 'package:pov2/core/widget/custom_auth.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_layout.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';
import 'package:pov2/core/widget/custom_textfield.dart';
import 'package:local_auth/local_auth.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailable();
  }

  Future<void> _checkBiometricAvailable() async{
    bool available = await FingerprintHelper.checkAvailability(auth);
    isBiometricAvailable = available;
  }
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
                Row(
                  children: [
                    Expanded(
                      child: CustomButtonFull(
                        textStyle: AppText.heading3Tertiary,
                        title: 'Masuk',
                        backgroundColor: AppColor.primary,
                        padding: EdgeInsets.symmetric(
                          vertical: AppSpacing.xs,
                          horizontal: AppSpacing.md,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    InkWell(
                      onTap: () async{
                        if(isBiometricAvailable == false){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Biometric isn't available in your device"),
                                backgroundColor: AppColor.error,
                              )
                          );
                        }

                        bool authenticate = await FingerprintHelper.biometricAuthentication(auth, isBiometricAvailable);
                        if(authenticate){
                          context.goNamed(
                              AppRoutes.home.name,
                              pathParameters: {
                                'user': 'FO'
                              }
                          );
                        }
                      },
                      child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColor.onAccentMedium,
                            shape: BoxShape.circle
                          ),
                          child: Icon(Icons.fingerprint_outlined, size: 40, color: AppColor.accentMedium,)
                      ),
                    )
                  ],
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

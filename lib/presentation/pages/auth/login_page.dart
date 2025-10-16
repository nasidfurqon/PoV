import 'package:email_validator/email_validator.dart';
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
import 'package:pov2/core/widget/custom_progress_indicator.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';
import 'package:pov2/core/widget/custom_textfield.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pov2/data/models/mtUser_model.dart';
import 'package:pov2/data/services/get_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pov2/data/services/auth_service.dart';

import '../../../data/models/login_model.dart';
import '../../../data/services/user_notifier.dart';
final loginProvider = StateNotifierProvider<LoginProvider, LoginModel>((ref) => LoginProvider());

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailable();
  }

  Future<void> _checkBiometricAvailable() async{
    bool available = await FingerprintHelper.checkAvailability(auth);
    setState(() {
      isBiometricAvailable = available;
    });
  }
  @override
  Widget build(BuildContext context) {
    final loginNotifier = ref.read(loginProvider.notifier);
    final state = ref.watch(loginProvider);

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
                  onChanged: (value) {
                    loginNotifier.setUsername(value);
                  },
                ),
                SizedBox(height: AppSpacing.md),
                CustomTextFieldWithLabel(
                  keyboardType: TextInputType.visiblePassword,
                  label: "Password",
                  hint: "***",
                  obscureText: true,
                  onChanged: (value) {
                    loginNotifier.setPassword(value);
                  },
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
                        onPressed: () async{
                          try{
                            print('TES BUTTON LOGIN');
                            if (state.email.isEmpty ||
                                state.password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Username and password required'),
                                  backgroundColor: AppColor.error,
                                ),
                              );
                              return;
                            }

                            if (!EmailValidator.validate(
                                state.email)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invalid email format'),
                                  backgroundColor: AppColor.error,
                                ),
                              );
                              return;
                            }
                            CustomProgressIndicator.showLoadingDialog(context);
                            print("STATE EMAIL : ${state.email}");
                            print("STATE PASSWORD : ${state.password}");
                            Map<String, dynamic> responseLogin = await AuthService.login(ref, state.email, state.password);
                            print('RESPONSE API LOGIN : $responseLogin');

                            var pref = await SharedPreferences.getInstance();
                            if(responseLogin['success'] == true){
                              pref.setString('jwtToken', responseLogin['JWT']);
                              Map<String, dynamic> decodedToken = JwtDecoder.decode(responseLogin['JWT']);
                              String userId = decodedToken['UserId'].toString();
                              print("USER ID USER LOGIN : $userId");
                              pref.setString('userId', userId);
                              MTUserModel? userData =  await GetService.getUser(userId);
                              await ref.read(userProvider.notifier).login(userData!);
                              print("EMPLOYEE ID AFTER LOGIN = ${userData!.employeeId.toString()}");
                              pref.setString('employeeId', userData.employeeId.toString());
                              CustomProgressIndicator.hideLoading();
                              context.goNamed(AppRoutes.home.name, pathParameters: {
                                'user': 'Administrator',
                                'ID': userId
                              });
                            }
                            else{
                              CustomProgressIndicator.hideLoading();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text('Login Failed'),
                                  backgroundColor: AppColor.error,
                                ),
                              );
                            }
                          }
                          catch(e, stack){
                            CustomProgressIndicator.hideLoading();
                            print('RESPONSE LOGIN GAGAL : $e');
                            print('STACKTRACE: $stack');
                          }
                        },
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

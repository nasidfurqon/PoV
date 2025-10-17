import 'package:flutter/material.dart';
import 'package:pov2/config/router/app_routes.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:go_router/go_router.dart';
import 'package:pov2/data/services/user_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  bool _isTokenValid(String? token){
    if(token == null || token.trim().isEmpty) return false;
    final parts = token.split('.');
    return parts.length == 3;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(const Duration(seconds: 1), () async{
      var pref = await SharedPreferences.getInstance();
      var jwt =  pref.getString('jwtToken');
      var userId = await pref.getString('userId');
      final isValid = _isTokenValid(jwt);
      print('JWT CHECK = $isValid');
      if(isValid) {
        try{
          final isExpired = JwtDecoder.isExpired(jwt!);
          await ref.read(userProvider.notifier).loadUserFromStorage();
          print('SHIMMER CHECK : IS EXPIRED = $isExpired');
          if(!isExpired){
            if(context.mounted){
              context.goNamed(AppRoutes.home.name, pathParameters: {
                'user': 'Administrator',
                'ID': userId ?? ''
              });
            }
            return;
          }
        }
        catch(e){
          print('JWT ERROR: $e');
        }
      }
      await pref.remove('jwtToken');
      if(context.mounted){
        if(context.mounted){
          context.goNamed(AppRoutes.login.name);
        }
      }
    });
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppSpacing.xxxl ,),
            const Text(
              'Proof-of-Visit',
              style: TextStyle(
                color: AppColor.textTertiary,
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.xxxl),
            Column(
              children: [
                Text('presented by:', style: AppText.heading3Tertiary,),
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

import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_layout.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';

class CustomAuth extends StatefulWidget {
  final Widget child;
  const CustomAuth({super.key, required this.child});

  @override
  State<CustomAuth> createState() => _CustomAuthState();
}

class _CustomAuthState extends State<CustomAuth> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: AppLayout(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: CustomCard(
            padding: EdgeInsets.all(AppSpacing.global),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppSpacing.lg),
                const Text('Sistem PoV', style: AppText.headingPrimary),
                SizedBox(height: AppSpacing.md),
                const Text(
                  'Masuk untuk mengakses sistem Proof-of-Visit Pertamina Patraniaga',
                  textAlign: TextAlign.center,
                  style: AppText.caption3,
                ),
                SizedBox(height: AppSpacing.md),
                widget.child
              ],
            ),
          ),
        ),
      ),
    );
  }
}

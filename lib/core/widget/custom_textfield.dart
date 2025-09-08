import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';

class CustomTextfield extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType? keyboardType; 
  final bool obscureText;
  const CustomTextfield({super.key, this.obscureText = false, required this.label, required this.hint, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppText.body,
        ),
        SizedBox(height: AppSpacing.xs),
        TextFormField(
          obscureText: obscureText  ,
          keyboardType: keyboardType ?? TextInputType.text,
          style: AppText.body,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppText.caption,
            contentPadding: EdgeInsets.all(AppSpacing.md),
            filled: true,
            fillColor: AppColor.background,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: BorderSide(color: AppColor.primary, width: 1.5)
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: BorderSide(color: AppColor.border),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: BorderSide(color: AppColor.textSecondary)
            )

          ),
        )
      ],
    );
  }
}
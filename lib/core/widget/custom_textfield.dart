import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';


class CustomTextField extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final int? maxLines;
  const CustomTextField({super.key,this.onChanged, this.controller, this.obscureText = false,required this.hint, this.maxLines, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          obscureText: obscureText  ,
          keyboardType: keyboardType ?? TextInputType.text,
          style: AppText.body,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppText.caption,
              contentPadding: EdgeInsets.all(AppSpacing.sm),
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
          onChanged: (value){
            if(onChanged != null){
              return onChanged!(value);
            }
          },
          controller: controller,
        )
      ],
    );
  }
}

class CustomTextFieldWithLabel extends StatelessWidget {
  final String label;
  final TextStyle? textStyle;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  final int? maxLines;
  const CustomTextFieldWithLabel({super.key,this.onChanged, this.controller, this.textStyle, this.maxLines, this.obscureText = false, required this.label, required this.hint, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textStyle ?? AppText.body,
        ),
        SizedBox(height: AppSpacing.xxs),
        CustomTextField(hint: hint, maxLines: maxLines, controller: controller,keyboardType: keyboardType, obscureText: obscureText, onChanged: onChanged,)
      ],
    );
  }
}
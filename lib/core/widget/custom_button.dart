import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets padding;
  final double? borderRadius;
  final Function() onPressed;
  final TextStyle textStyle;
  final IconData? icon;
  final Color? iconColor;
  final bool? isActive;
  final BorderSide? borderSide;
  const CustomButton({super.key, this.borderSide,    this.isActive = true, this.icon, this.iconColor, required this.textStyle, required this.title, required this.backgroundColor, this.foregroundColor, required this.padding, this.borderRadius, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isActive == true ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? AppSpacing.sm),
          side: borderSide ?? BorderSide.none
        ),
        elevation: 0,
      ),
      child: icon != null ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor ?? AppColor.background, size: AppSpacing.lg,),
          SizedBox(width: AppSpacing.xs),
          Text(
            title,
            style: textStyle,
          ),
        ],
      ) :
      Text(
        title,
        style: textStyle,
      ),
    );
  }
}


class CustomButtonFull extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets padding;
  final double? borderRadius;
  final Function() onPressed;
  final TextStyle textStyle;
  final IconData? icon;
  final Color? iconColor;
  final bool? isActive;
  final BorderSide? borderSide;
  const CustomButtonFull({super.key, this.borderSide, this.iconColor, this.isActive = true  , this.icon, required this.textStyle, required this.title, required this.backgroundColor, this.foregroundColor, required this.padding, this.borderRadius, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(textStyle: textStyle, borderSide: borderSide, borderRadius: borderRadius, isActive: isActive, iconColor: iconColor, icon: icon, title: title, backgroundColor: backgroundColor, padding: padding, onPressed: onPressed),
    );
  }
}




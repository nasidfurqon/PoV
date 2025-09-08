import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets padding;
  final double? borderRadius;
  final Function() onPressed;
  final TextStyle textStyle;
  const CustomButton({super.key, required this.textStyle, required this.title, required this.backgroundColor, this.foregroundColor, required this.padding, this.borderRadius, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
      
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? AppSpacing.sm)
        ),
        elevation: 0,
      ),
      child: Text(
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
  const CustomButtonFull({super.key, required this.textStyle, required this.title, required this.backgroundColor, this.foregroundColor, required this.padding, this.borderRadius, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(textStyle: textStyle, title: title, backgroundColor: backgroundColor, padding: padding, onPressed: onPressed),
    );
  }
}




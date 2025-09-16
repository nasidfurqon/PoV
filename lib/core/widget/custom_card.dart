import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';

class CustomCard extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;
  final double? borderRadius;
  final double? height;
  final Color? color;
  final Gradient? gradient;
  final bool? isBoxShadow;
  CustomCard({super.key,this.color, this.height, this.gradient, this.isBoxShadow = true,required this.padding, required this.child,  this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: height ?? null,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: gradient,
          color:  gradient == null ? (color ?? AppColor.background) : null,
          borderRadius: BorderRadius.circular(borderRadius ?? AppSpacing.radiusLg),
          border: Border.all(
            color: AppColor.border,
            width: (isBoxShadow == true) ?  1 : 0
          ),
          boxShadow: [BoxShadow(
            color: Color.fromARGB(8, 0, 0, 0),
            blurRadius: 8,
            offset: Offset(0, 2),
          )]
        ),
        child: child
      ),
    );
  }
}
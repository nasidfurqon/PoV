import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double? borderRadius;
  final Color? color;
  CustomCard({super.key,this.color, required this.child, required this.padding, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color ?? AppColor.background,
          borderRadius: BorderRadius.circular(borderRadius ?? AppSpacing.radiusSm),
          border: Border.all(
            color: AppColor.border,
            width: 1
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
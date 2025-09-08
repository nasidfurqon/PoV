import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      fit: StackFit.expand,
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned(
          top: -340,
          left: -100,
          child: Container(
            width: MediaQuery.of(context).size.width + 200,
            height: MediaQuery.of(context).size.width+200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primary
            ),
          ),
        ),
        child
      ],
    );
  }
}
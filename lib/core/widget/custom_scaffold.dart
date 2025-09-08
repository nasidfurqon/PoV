import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  const CustomScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/patra-tanpa-bg.png',
          width: 180,
          color: AppColor.background,
        ),
        centerTitle: true,
      ),
      body: body,
    );
  }
}
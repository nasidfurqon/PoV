import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_color.dart';

class CustomNormalScaffold extends StatelessWidget {
  final Widget body;
  final Widget title;
  final BuildContext context;
  const CustomNormalScaffold({super.key, required this.context, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColor.textPrimary),
            onPressed: () {context.pop();}
        ),
        title: title
      ),
      body: body,
    );
  }
}

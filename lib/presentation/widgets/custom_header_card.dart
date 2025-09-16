import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_card.dart';

class CustomHeaderCard extends StatelessWidget {
  final String number;
  final String status;
  const CustomHeaderCard({super.key, required this.number, required this.status});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      isBoxShadow: false ,
      color: ParsingColor.cekColor(status)[1],
      padding: EdgeInsets.zero,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              color: ParsingColor.cekColor(status)[0],
            )
          ),
          Text(
            status,
            style: TextStyle(
                fontSize: 16,
                color: ParsingColor.cekColor(status)[0],
            )
          )
        ],
      ),
    );
  }
}
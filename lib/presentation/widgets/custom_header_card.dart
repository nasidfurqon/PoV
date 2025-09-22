import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_card.dart';

import '../../config/theme/app_spacing.dart';

class CustomHeaderCard extends StatelessWidget {
  final String number;
  final String status;
  final double? height;
  const CustomHeaderCard({super.key, this.height, required this.number, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Container(
          height: height ?? 80,
          width: double.infinity,
          decoration: BoxDecoration(
              color:  ParsingColor.cekColor(status)[1],
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(
                  color: ParsingColor.cekColor(status)[0],
                  width: 1
              ),
              boxShadow: [BoxShadow(
                color: Color.fromARGB(8, 0, 0, 0),
                blurRadius: 8,
                offset: Offset(0, 2),
              )]
          ),
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
      ),
    );
  }
}
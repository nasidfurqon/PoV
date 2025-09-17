import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/core/widget/custom_card.dart';

class CustomModelDialog{
  static void show(BuildContext context, Widget title, Widget child){
    showDialog(
        context: context,
        builder: (ctx){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: CustomCard(
                height: 600,
                padding: EdgeInsets.zero,
                color: AppColor.textTertiary,
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.global),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: title),
                            SizedBox(width: AppSpacing.sm,),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.black, size: AppSpacing.xl,),
                              onPressed: () => Navigator.of(ctx).pop(),
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: AppSpacing.xs),
                        child
                      ],
                    ),
                  ),
                )
            ),
          );
        }
    );
  }
}
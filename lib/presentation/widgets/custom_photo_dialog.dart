import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';

import 'custom_highlight_dashboard.dart';
import 'custom_row_icon.dart';

class CustomPhotoDialog {
  static void show(BuildContext context, String photo, String condition, String description, String datetime, String location) {
    Color tagColor;
    Color bgColor;
    String tagText;

    switch (condition) {
      case 'evidence':
        tagColor = AppColor.accentMedium;
        bgColor = AppColor.onAccentMedium;
        tagText = 'evidence';
        break;
      case 'before':
        tagColor = AppColor.accentHigh;
        bgColor = AppColor.onAccentHigh;
        tagText = 'before';
        break;
      case 'completion':
        tagColor = AppColor.accentCompletion;
        bgColor = AppColor.onAccentCompletion;
        tagText = 'completion';
        break;
      default:
        tagColor = Colors.grey;
        bgColor = Colors.black;
        tagText = 'photo';
    }

    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusLg)),
          child: CustomCard(
            color: AppColor.textTertiary,
            padding: EdgeInsets.zero,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 600,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  AppSpacing.md),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Photo Evidence', style: AppText.heading3,),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.black, size: AppSpacing.xl,),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm,), 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  AppSpacing.xxl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CustomCard(
                            isBoxShadow: false,
                            height: 300,
                            padding: EdgeInsets.zero,
                            child: Padding(
                              padding: EdgeInsets.all(AppSpacing.global),
                              child: photo != null
                                  ? Image.asset(photo, fit: BoxFit.cover)
                                  : const Icon(Icons.image, size: 80, color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:  AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Photo Detail', style: AppText.heading4,),
                            SizedBox(height: AppSpacing.xs,),
                            CustomHighlightDashboard(
                                title: tagText,
                                customFontStyle: true,
                                fontWeight: FontWeight.bold,
                                fontSize: 9,
                                fontColor: tagColor,
                                containerColor: bgColor
                            ),
                            SizedBox(height: AppSpacing.xs,),
                            Text(description, style: AppText.heading6Secondary,),
                            SizedBox(height: AppSpacing.xs,),
                            CustomRowIcon(icon:  Icons.access_time_outlined, color: AppColor.textSecondary, title:'9/10/2025, 6:14:33 PM',textStyle:  AppText.heading6Secondary),
                            SizedBox(height: AppSpacing.xs,),
                      
                            SizedBox(height: AppSpacing.sm,),
                                    
                            Text('Verification Data', style: AppText.heading4,),
                            SizedBox(height: AppSpacing.xs,),
                            CustomRowIcon(icon:  Icons.location_on_outlined, color:  AppColor.textSecondary,title:location,textStyle:  AppText.heading6Secondary),
                            SizedBox(height: AppSpacing.xs,),
                            CustomRowIcon(icon:  Icons.camera_alt_outlined, color:  AppColor.textSecondary, title:'before.jpg', textStyle:  AppText.heading6Secondary),
                            SizedBox(height: AppSpacing.xs,),
                            Text('Size: 1813KB', style: AppText.heading6Secondary,),
                            SizedBox(height: AppSpacing.xs,),
                            CustomHighlightDashboard(
                                title: 'Watermark Verified',
                                customFontStyle: true,
                                fontWeight: FontWeight.bold,
                                fontSize: 9,
                                fontColor: AppColor.accentCompleted ,
                                containerColor: AppColor.onAccentCompleted
                            ),
                            SizedBox(height: AppSpacing.sm),

                            CustomButtonFull(
                                icon: Icons.download_outlined,
                                iconColor: AppColor.textPrimary,
                                borderSide: BorderSide(
                                  color: AppColor.textPrimary,
                                  width: 1
                                ),
                                textStyle: AppText.heading5,
                                title: 'Download',
                                backgroundColor: AppColor.background,
                                padding: EdgeInsets.symmetric(vertical: 0),
                                onPressed: (){

                                }
                            ),
                            SizedBox(height: AppSpacing.md),
                          ],
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

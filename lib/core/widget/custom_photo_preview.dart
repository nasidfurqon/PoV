import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';

class CustomPhotoPreview extends StatelessWidget {
  final File? photo;
  const CustomPhotoPreview({super.key, this.photo});

  @override
  Widget build(BuildContext context) {
      if(photo == null){
        return SizedBox();
      }
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.md),
        child: Image.file(
          photo!,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      );
  }
}

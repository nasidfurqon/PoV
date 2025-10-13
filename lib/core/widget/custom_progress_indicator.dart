import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';

import '../../config/theme/app_color.dart';

class   CustomProgressIndicator{
  static BuildContext? _dialogContext;

  static showLoadingDialog(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,
        builder:(BuildContext dialogContext){
          _dialogContext = dialogContext;
          return const AlertDialog(
            content: SizedBox(
              height: 90,
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: AppSpacing.lg),
                  Text('Procesing..', style: AppText.heading4,)
                ],
              ),
            ),
          );
        }
    );
  }

  static showUploadingDialog(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,
        builder:(BuildContext dialogContext){
          _dialogContext = dialogContext;
          return const AlertDialog(
            content: SizedBox(
              height: 23,
              child: Column(
                children: [
                  Text('Uploading..', style: AppText.heading4,)
                ],
              ),
            ),
          );
        }
    );
  }

  static Widget showInformation(BuildContext context, String information, String type){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 80, color: type == 'Error' ?  AppColor.error : AppColor.primary),
          const SizedBox(height: 12),
          Text(
            information,
            style: AppText.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static void hideLoading() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _dialogContext = null;
    }
  }

}
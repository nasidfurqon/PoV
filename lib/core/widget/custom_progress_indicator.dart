import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';

class CustomProgressIndicator{
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
                  Text('Procesing..')
                ],
              ),
            ),
          );
        }
    );
  }

  static void hideLoading() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _dialogContext = null;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';

class CustomAller{
  Future<bool> showConfirmDialog(BuildContext context, String title, String message) async {
    return (await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Navigator.pop(context, true), child: const Text('Yes')),
        ],
      ),
    )) ?? false;
  }

}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pov2/config/theme/app_spacing.dart';

class CustomFilePreview extends StatelessWidget {
  final PlatformFile? file;
  const CustomFilePreview({super.key, this.file});

  @override
  Widget build(BuildContext context) {
    if(file == null){
      return SizedBox();
    }
    return ListTile(
      leading: const Icon(Icons.insert_drive_file, color: Colors.blue),
      title: Text(file!.name, overflow: TextOverflow.ellipsis),
      subtitle: Text("${(file!.size / (1024 * 1024)).toStringAsFixed(2) } MB"),
    );
  }
}

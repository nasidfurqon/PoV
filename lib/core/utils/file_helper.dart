import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:pov2/config/theme/app_color.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dart:typed_data';

class FileHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickPhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<PlatformFile?> pickDocument() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'txt', 'jpg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files.first;
    }

    return null;
  }
}
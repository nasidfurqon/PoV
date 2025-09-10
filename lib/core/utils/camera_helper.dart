import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../widget/custom_progress_indicator.dart';
class CameraHelper{
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> takePhoto() async{
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if(pickedFile != null){
      return File(pickedFile.path);
    }
    return null;
  }
}
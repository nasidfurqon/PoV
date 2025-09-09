import 'dart:io';

import 'package:image_picker/image_picker.dart';
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
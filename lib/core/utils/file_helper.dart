import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class FileHelper{
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickPhoto() async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<PlatformFile?> pickDocument() async{
    final result  = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'txt', 'jpg', 'png'],
    );

    if(result != null && result.files.isNotEmpty){
      return result.files.first;
    }

    return null;
  }
}
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:pov2/data/models/file_watermark_model.dart';

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

  static Future<File> addTextandLogoWatermark(
      File imageFile,
      List<FileWatermarkModel> rows) async {

    Uint8List bytes = await imageFile.readAsBytes();
    img.Image? originalImage = img.decodeImage(bytes);

    if (originalImage == null) {
      throw Exception("Gagal decode gambar utama");
    }

    int logoSize = (originalImage.height * 0.03).toInt();
    int spacingY = (originalImage.height * 0.01).toInt();
    int padding = (originalImage.height * 0.02).toInt();
    print('IMAGE UPLOADED HIGH = ${originalImage.height}');

    img.BitmapFont font;
    if(originalImage.height > 2000){
      font = img.arial48;
    }
    else if (originalImage.height > 1000) {
      font = img.arial24;
    } else {
      font = img.arial14;
    }

    final panelHeight = rows.length * (logoSize + spacingY) + padding + 10;
    img.fillRect(
        originalImage,
        x1: 0,
        y1: originalImage.height - panelHeight,
        x2: originalImage.width,
        y2: originalImage.height,
        color: img.ColorRgba8(0, 0, 0, 120)
    );
    
    int y = originalImage.height - panelHeight + padding ~/ 2;

    for (var row in rows) {
      final logoData = await rootBundle.load(row.assetLogo);
      final logoBytes = logoData.buffer.asUint8List();
      img.Image? logoImage = img.decodeImage(logoBytes);

      if (logoImage != null) {
        final resizedLogo = img.copyResize(logoImage, width: logoSize);

        img.compositeImage(
          originalImage,
          resizedLogo,
          dstX: padding,
          dstY: y,
        );

        img.drawString(
          originalImage,
          font: font,
          x: padding + logoSize + 10,
          y: y + (logoSize ~/ 4),
          row.text,
          color: img.ColorRgb8(255, 255, 255)
        );
      }

      y += logoSize + spacingY;
    }

    const String staticText = "PoV System - Verified Evidence";
    img.drawString(
      originalImage,
      font: font,
      x: padding,
      y: y,
      staticText,
      color: img.ColorRgb8(200, 200, 200)
    );

    final watermarkedBytes = img.encodeJpg(originalImage);

    final newFile = File(
        '${imageFile.parent.path}/watermarked_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await newFile.writeAsBytes(watermarkedBytes);

    return newFile;
  }
}
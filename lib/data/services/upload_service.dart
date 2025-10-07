import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../core/utils/config.dart';

class  UploadService{
  static Future<bool> evidenceFile(Map<String, dynamic> data) async{
    var pref = await SharedPreferences.getInstance();
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${AppConfig.serverAddress}/api/uploadEvidence/EvidenceFile"),
      );

      request.headers['Authorization'] = 'Bearer ${pref.getString('jwtToken')}';
      request.fields['ScheduleID'] = data['TRVisitationScheduleID'].toString();
      request.fields['UserID'] = pref.getString('userId').toString();
      request.fields['Remark'] = data['Remark'];
      request.fields['EvidenceType'] = data['EvidenceType'];
      request.fields['AttachmentType'] = data['AttachmentType'];

      request.files.add(
        await http.MultipartFile.fromPath('File', data['Attachment'].path),
      );
      print('API UPLOAD EVIDENCE CHECK FILE = ${(data['Attachment']).path}\nCHECK SCHE ID = ${data['TRVisitationScheduleID']}');

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('API UPLOAD EVIDENCE CHECK ${jsonDecode(response.body)}');
        return true;
      } else {
        print("Failed to upload evidence: ${response.body}");
        return false;
      }
    }
    catch(e){
      print('RESPONSE UPLOAD EVIDENCE FILE SCHEDULE FAILED : $e');
      return false;
    }
  }

  static Future<bool> selfieFile(Map<String, dynamic> data) async{
    var pref = await SharedPreferences.getInstance();
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${AppConfig.serverAddress}/api/uploadEvidence/SelfieFile"),
      );
      request.headers['Authorization'] = 'Bearer ${pref.getString('jwtToken')}';
      request.fields['ScheduleID'] = data['TRVisitationScheduleID'].toString();
      request.fields['UserID'] = pref.getString('userId').toString();

      request.files.add(
        await http.MultipartFile.fromPath('File', data['File'].path),
      );

      print('API UPLOAD SELFIE CHECK FILE = ${(data['File']).path}\nCHECK SCHE ID = ${data['TRVisitationScheduleID']}');
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('API UPLOAD SELFIE CHECK ${jsonDecode(response.body)}');
        return true;
      } else {
        print("Failed to upload selfie: ${response.body}");
        return false;
      }
    }
    catch(e){
      print('RESPONSE UPLOAD SELFIE  SCHEDULE FAILED : $e');
      return false;
    }
  }
}
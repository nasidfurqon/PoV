
import 'dart:math';

import 'package:pov2/core/utils/parsing_helper.dart';

class DocumentationModel{
  final String? scheduleId;
  final String? fullName;
  final String? employeeID;
  final String? locationName;
  final String? date;
  final String? countPhoto;
  final String? countDocument;
  final String? countVideo;
  final String? totalSizePhoto;
  final String? totalSizeDocument;
  final String? totalSizeVideo;
  final String? type;
  final List<dynamic>? attachment;
  DocumentationModel(
      {this.locationName, this.countPhoto, this.countDocument, this.countVideo, this.fullName, this.employeeID, this.scheduleId, this.date, this.attachment, this.type, this.totalSizePhoto, this.totalSizeDocument, this.totalSizeVideo});

  factory DocumentationModel.fromJson(Map<String, dynamic> data) {
    List<dynamic> attachments = [];
    if(data['Attachments'] is List<Map<String, dynamic>>){
      print('CEK ATTAHCMENT');
      for(var data in data['Attachments']){
        attachments.add(data['FileName']);
      }
    }
    else{
      print('CEK ATTAHCMENT 2');
      attachments = data['Attachments'];
    }
    return DocumentationModel(
      scheduleId: data['ScheduleID'].toString(),
      fullName: data['FullName'],
      employeeID: data['EmployeeID'],
      locationName: data['LocationName'],
      date: ParsingHelper.splitTimePre(data['LatestCreated']),
      countDocument: data['CountDocument'].toString(),
      countPhoto: data['CountPhoto'].toString(),
      countVideo: data['CountVideo'].toString(),
      totalSizePhoto: data['TotalPhotoSize'],
      totalSizeDocument: data['TotalDocumentSize'],
      type: data['Type'],
      totalSizeVideo: data['TotalVideoSize'],
      attachment:  data['Attachments']
    );
  }
}
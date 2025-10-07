import 'package:pov2/core/utils/parsing_helper.dart';

class TRVisitationScheduleModel {
  final int? id;
  final String? mtAssignedUserId;
  final String? mtLocationId;
  final String? mtVisitationPurposeId;
  final String? visitationDescription;
  final String? startDateTime;
  final String? endDateTime;
  final String? actualStartDateTime;
  final String? actualEndDateTime;
  final String? priority;
  final String? status;
  final String? facePhotoEvidence;
  final String? assignedUserAckDateTime;
  final String? assignedUserRemark;
  final String? createdByUserId;
  final String? createdDateTime;
  final String? lastUpdatedByUserId;
  final String? lastUpdatedDateTime;

  TRVisitationScheduleModel({
    this.id,
    this.mtAssignedUserId,
    this.mtLocationId,
    this.mtVisitationPurposeId,
    this.visitationDescription,
    this.startDateTime,
    this.endDateTime,
    this.actualStartDateTime,
    this.actualEndDateTime,
    this.priority,
    this.status,
    this.facePhotoEvidence,
    this.assignedUserAckDateTime,
    this.assignedUserRemark,
    this.createdByUserId,
    this.createdDateTime,
    this.lastUpdatedByUserId,
    this.lastUpdatedDateTime,
  });

  factory TRVisitationScheduleModel.fromJson(Map<String, dynamic> data) {
    var photo = '';
    if(data['FacePhotoEvidence'] is String){
      photo = data['FacePhotoEvidence'];
    }
    else{
      photo = data['FacePhotoEvidence']['name'];
    }
    return TRVisitationScheduleModel(
      id: ParsingHelper.parseInt(data['ID']) ?? 0,
      mtAssignedUserId: (data['MTAssignedUserID']).toString(),
      mtLocationId: (data['MTLocationID']).toString(),
      mtVisitationPurposeId: (data['MTVisitationPurposeID']).toString(),
      visitationDescription: data['VisitationDescription'],
      startDateTime: data['StartDateTime'] != null ? (data['StartDateTime']) : null,
      endDateTime: data['EndDateTime'] != null ? (data['EndDateTime']) : null,
      actualStartDateTime: data['ActualStartDateTime'] != null ? (data['ActualStartDateTime']) : null,
      actualEndDateTime: data['ActualEndDateTime'] != null ? (data['ActualEndDateTime']) : null,
      priority: data['Priority'],
      status: data['Status'],
      facePhotoEvidence: photo,
      assignedUserAckDateTime: data['AssignedUserAckDateTime'] != null ? ParsingHelper.splitTimePre(data['AssignedUserAckDateTime']) : null,
      assignedUserRemark: data['AssignedUserRemark'],
      createdByUserId: (data['CreatedByUserID']).toString(),
      createdDateTime: data['CreatedDateTime'] != null ? ParsingHelper.splitTimePre(data['CreatedDateTime']) : null,
      lastUpdatedByUserId: (data['LastUpdatedByUserID']).toString(),
      lastUpdatedDateTime: data['LastUpdatedDateTime'] != null ? ParsingHelper.splitTimePre(data['LastUpdatedDateTime']) : null,
    );
  }

  factory TRVisitationScheduleModel.convertToModel(
      TRVisitationScheduleModel current, Map<String, dynamic> data) {
    return TRVisitationScheduleModel(
      mtAssignedUserId: (data['MTAssignedUserID'] ?? current.mtAssignedUserId).toString(),
      mtLocationId: (data['MTLocationID'] ?? current.mtLocationId).toString(),
      mtVisitationPurposeId: (data['MTVisitationPurposeID'] ?? current.mtVisitationPurposeId).toString(),
      visitationDescription: data['VisitationDescription'] ?? current.visitationDescription,
      startDateTime: data['StartDateTime'] ?? current.startDateTime,
      endDateTime: data['EndDateTime'] ?? current.endDateTime,
      actualStartDateTime: data['ActualStartDateTime'] ?? current.actualStartDateTime,
      actualEndDateTime: data['ActualEndDateTime'] ?? current.actualEndDateTime,
      priority: data['Priority'] ?? current.priority,
      status: data['Status'] ?? current.status,
      facePhotoEvidence: data['FacePhotoEvidence'] ?? current.facePhotoEvidence,
      assignedUserAckDateTime: data['AssignedUserAckDateTime'] ?? current.assignedUserAckDateTime,
      assignedUserRemark: data['AssignedUserRemark'] ?? current.assignedUserRemark,
      createdByUserId: (data['CreatedByUserID'] ?? current.createdByUserId).toString(),
      createdDateTime: data['CreatedDateTime'] ?? current.createdDateTime,
      lastUpdatedByUserId: (data['LastUpdatedByUserID'] ?? current.lastUpdatedByUserId).toString(),
      lastUpdatedDateTime: data['LastUpdatedDateTime'] ?? current.lastUpdatedDateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MTAssignedUserID': mtAssignedUserId ?? '',
      'MTLocationID': mtLocationId ?? '',
      'MTVisitationPurposeID': mtVisitationPurposeId ?? '',
      'VisitationDescription': visitationDescription ?? '',
      'StartDateTime': startDateTime ?? '',
      'EndDateTime': endDateTime ?? '',
      'ActualStartDateTime': actualStartDateTime ?? '',
      'ActualEndDateTime': actualEndDateTime ?? '',
      'Priority': priority ?? '',
      'Status': status ?? '',
      'FacePhotoEvidence': facePhotoEvidence ?? '',
      'AssignedUserAckDateTime': assignedUserAckDateTime ?? '',
      'AssignedUserRemark': assignedUserRemark ?? '',
      'CreatedByUserID': createdByUserId ?? '',
      'CreatedDateTime': createdDateTime ?? '',
      'LastUpdatedByUserID': lastUpdatedByUserId ?? '',
      'LastUpdatedDateTime': lastUpdatedDateTime ?? '',
    };
  }
}


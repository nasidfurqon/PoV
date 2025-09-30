import 'package:pov2/core/utils/parsing_helper.dart';

class TRVisitationScheduleModel {
  final int id;
  final int? mtAssignedUserId;
  final int? mtLocationId;
  final int? mtVisitationPurposeId;
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
  final int? createdByUserId;
  final String? createdDateTime;
  final int? lastUpdatedByUserId;
  final String? lastUpdatedDateTime;

  TRVisitationScheduleModel({
    required this.id,
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
    return TRVisitationScheduleModel(
      id: ParsingHelper.parseInt(data['ID']) ?? 0,
      mtAssignedUserId: ParsingHelper.parseInt(data['MTAssignedUserID']),
      mtLocationId: ParsingHelper.parseInt(data['MTLocationID']),
      mtVisitationPurposeId: ParsingHelper.parseInt(data['MTVisitationPurposeID']),
      visitationDescription: data['VisitationDescription'],
      startDateTime: data['StartDateTime'] != null ? (data['StartDateTime']) : null,
      endDateTime: data['EndDateTime'] != null ? (data['EndDateTime']) : null,
      actualStartDateTime: data['ActualStartDateTime'] != null ? (data['ActualStartDateTime']) : null,
      actualEndDateTime: data['ActualEndDateTime'] != null ? (data['ActualEndDateTime']) : null,
      priority: data['Priority'],
      status: data['Status'],
      facePhotoEvidence: data['FacePhotoEvidence'],
      assignedUserAckDateTime: data['AssignedUserAckDateTime'] != null ? ParsingHelper.splitTimePre(data['AssignedUserAckDateTime']) : null,
      assignedUserRemark: data['AssignedUserRemark'],
      createdByUserId: ParsingHelper.parseInt(data['CreatedByUserID']),
      createdDateTime: data['CreatedDateTime'] != null ? ParsingHelper.splitTimePre(data['CreatedDateTime']) : null,
      lastUpdatedByUserId: ParsingHelper.parseInt(data['LastUpdatedByUserID']),
      lastUpdatedDateTime: data['LastUpdatedDateTime'] != null ? ParsingHelper.splitTimePre(data['LastUpdatedDateTime']) : null,
    );
  }
}


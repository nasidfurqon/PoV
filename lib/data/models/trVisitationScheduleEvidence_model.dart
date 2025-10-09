import 'package:pov2/core/utils/parsing_helper.dart';

class TRVisitationScheduleEvidenceModel {
  final int? id;
  final int? trVisitationScheduleId;
  final String? evidenceType;
  final String? attachmentType;
  final String? attachment;
  final String? remark;
  final int? createdByUserId;
  final String? createdDateTime;
  final int? lastUpdatedByUserId;
  final String? lastUpdatedDateTime;

  TRVisitationScheduleEvidenceModel({
    this.id,
    this.trVisitationScheduleId,
    this.evidenceType,
    this.attachmentType,
    this.attachment,
    this.remark,
    this.createdByUserId,
    this.createdDateTime,
    this.lastUpdatedByUserId,
    this.lastUpdatedDateTime,
  });

  factory TRVisitationScheduleEvidenceModel.fromJson(Map<String, dynamic> data) {
    var evidence = '';
    if(data['FacePhotoEvidence'] is String){
      evidence = data['Attachment'];
    }
    else{
      evidence = data['Attachment']['name'];
    }
    return TRVisitationScheduleEvidenceModel(
      id: ParsingHelper.parseInt(data['ID']) ?? 0,
      trVisitationScheduleId: ParsingHelper.parseInt(data['TRVisitationScheduleID']),
      evidenceType: data['EvidenceType'],
      attachmentType: data['AttachmentType'],
      attachment: evidence,
      remark: data['Remark'],
      createdByUserId: ParsingHelper.parseInt(data['CreatedByUserID']),
      createdDateTime: data['CreatedDateTime'] != null ? ParsingHelper.splitTimePre(data['CreatedDateTime']) : null,
      lastUpdatedByUserId: ParsingHelper.parseInt(data['LastUpdatedByUserID']),
      lastUpdatedDateTime: data['LastUpdatedDateTime'] != null ? ParsingHelper.splitTimePre(data['LastUpdatedDateTime']) : null,
    );
  }

  factory TRVisitationScheduleEvidenceModel.convertToModel(
      TRVisitationScheduleEvidenceModel current, Map<String, dynamic> data) {
    return TRVisitationScheduleEvidenceModel(
      id: current.id,
      trVisitationScheduleId: ParsingHelper.parseInt(
          data['TRVisitationScheduleID']) ??
          current.trVisitationScheduleId,
      evidenceType: data['EvidenceType'] ?? current.evidenceType,
      attachmentType: data['AttachmentType'] ?? current.attachmentType,
      remark: data['Remark'] ?? current.remark,
      createdByUserId: ParsingHelper.parseInt(data['CreatedByUserID']) ??
          current.createdByUserId,
      createdDateTime:
      data['CreatedDateTime'] ?? current.createdDateTime,
      lastUpdatedByUserId: ParsingHelper.parseInt(data['LastUpdatedByUserID']) ??
          current.lastUpdatedByUserId,
      lastUpdatedDateTime:
      data['LastUpdatedDateTime'] ?? current.lastUpdatedDateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id ?? 0,
      'TRVisitationScheduleID': trVisitationScheduleId ?? '',
      'EvidenceType': evidenceType ?? '',
      'AttachmentType': attachmentType ?? '',
      'Attachment': attachment ?? '',
      'Remark': remark ?? '',
      'CreatedByUserID': createdByUserId ?? '',
      'CreatedDateTime': createdDateTime ?? '',
      'LastUpdatedByUserID': lastUpdatedByUserId ?? '',
      'LastUpdatedDateTime': lastUpdatedDateTime ?? '',
    };
  }
}

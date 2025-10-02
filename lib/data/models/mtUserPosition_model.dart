import '../../core/utils/parsing_helper.dart';

class MTUserPositionModel {
  final int id;
  final String? positionId;
  final String? positionName;
  final String? alias;
  final String? positionParentId;
  final String? kbo;
  final String? organizationId;
  final String? organizationName;
  final int? createdByUserId;
  final String? createdDateTime;
  final int? lastUpdatedByUserId;
  final String? lastUpdatedDateTime;

  MTUserPositionModel({
    required this.id,
    this.positionId,
    this.positionName,
    this.alias,
    this.positionParentId,
    this.kbo,
    this.organizationId,
    this.organizationName,
    this.createdByUserId,
    this.createdDateTime,
    this.lastUpdatedByUserId,
    this.lastUpdatedDateTime,
  });

  factory MTUserPositionModel.fromJson(Map<String, dynamic> data) {
    return MTUserPositionModel(
      id: ParsingHelper.parseInt(data['ID']) ?? 0,
      positionId: data['PositionID'],
      positionName: data['PositionName'],
      alias: data['Alias'],
      positionParentId: data['PositionParentID'],
      kbo: data['KBO'],
      organizationId: data['OrganizationID'],
      organizationName: data['OrganizationName'],
      createdByUserId: ParsingHelper.parseInt(data['CreatedByUserID']),
      createdDateTime: data['CreatedDateTime'] != null ? ParsingHelper.splitTimePre(data['CreatedDateTime']) : null,
      lastUpdatedByUserId: ParsingHelper.parseInt(data['LastUpdatedByUserID']),
      lastUpdatedDateTime: data['LastUpdatedDateTime'] != null ? ParsingHelper.splitTimePre(data['LastUpdatedDateTime']) : null,
    );
  }
}

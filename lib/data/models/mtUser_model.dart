import '../../core/utils/parsing_helper.dart';

class MTUserModel {
  final int id;
  final int? mtUserLevelId;
  final int? mtUserPositionId;
  final String? userName;
  final String? email;
  final String? fullName;
  final String? employeeId;
  final int? createdByUserId;
  final String? createdDateTime;
  final bool? isActive;
  final int? lastUpdatedByUserId;
  final String? lastUpdatedDateTime;

  MTUserModel({
    required this.id,
    this.mtUserLevelId,
    this.mtUserPositionId,
    this.userName,
    this.email,
    this.fullName,
    this.employeeId,
    this.createdByUserId,
    this.createdDateTime,
    this.isActive,
    this.lastUpdatedByUserId,
    this.lastUpdatedDateTime,
  });

  factory MTUserModel.fromJson(Map<String, dynamic> data) {
    return MTUserModel(
      id: ParsingHelper.parseInt(data['ID'])!,
      mtUserLevelId: ParsingHelper.parseInt(data['MTUserLevelID']),
      mtUserPositionId: ParsingHelper.parseInt(data['MTUserPositionID']),
      userName: data['UserName'],
      email: data['Email'],
      fullName: data['FullName'],
      employeeId: data['EmployeeID'].toString(),
      createdByUserId: ParsingHelper.parseInt(data['CreatedByUserID']),
      createdDateTime: data['CreatedDateTime'] != null ? ParsingHelper.splitTimePre(data['CreatedDateTime']) : null,
      isActive:ParsingHelper.parseBool(data['IsActive']),
      lastUpdatedByUserId: ParsingHelper.parseInt(data['LastUpdatedByUserID']),
      lastUpdatedDateTime: data['LastUpdatedDateTime'] != null ? ParsingHelper.splitTimePre(data['LastUpdatedDateTime']) : null,
    );
  }
}

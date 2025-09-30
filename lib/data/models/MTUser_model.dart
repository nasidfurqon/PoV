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
      id: data['ID'],
      mtUserLevelId: _parseInt(data['MTUserLevelID']),
      mtUserPositionId: _parseInt(data['MTUserPositionID']),
      userName: data['UserName'],
      email: data['Email'],
      fullName: data['FullName'],
      employeeId: data['EmployeeID'],
      createdByUserId: _parseInt(data['CreatedByUserID']),
      createdDateTime: data['CreatedDateTime'] != null ? _splitTime(data['CreatedDateTime']) : null,
      isActive: _parseBool(data['isActive']),
      lastUpdatedByUserId: _parseInt(data['LastUpdatedByUserID']),
      lastUpdatedDateTime: data['LastUpdatedDateTime'] != null ? _splitTime(data['LastUpdatedDateTime']) : null,
    );
  }

  static int? _parseInt(dynamic val) {
    if (val == null) return null;
    if (val is String) return int.tryParse(val);
    if (val is int) return val;
    return null;
  }

  static bool? _parseBool(dynamic val) {
    if (val == null) return null;
    if (val is bool) return val;
    if (val is int) return val == 1;
    if (val is String) return val.toLowerCase() == "true" || val == "1";
    return null;
  }

  static String _splitTime(dynamic date) {
    return date.toString().split('T')[0];
  }
}

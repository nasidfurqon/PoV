import 'package:pov2/core/utils/parsing_helper.dart';

class MTLocationTypeModel {
  final int id;
  final String? code;
  final String? name;
  final String? remark;
  final int? createdByUserId;
  final String? createdDateTime;
  final int? lastUpdatedByUserId;
  final String? lastUpdatedDateTime;

  MTLocationTypeModel({
    required this.id,
    this.code,
    this.name,
    this.remark,
    this.createdByUserId,
    this.createdDateTime,
    this.lastUpdatedByUserId,
    this.lastUpdatedDateTime,
  });

  factory MTLocationTypeModel.fromJson(Map<String, dynamic> data) {
    return MTLocationTypeModel(
      id: ParsingHelper.parseInt(data['ID']) ?? 0,
      code: data['Code'],
      name: data['Name'],
      remark: data['Remark'],
      createdByUserId: ParsingHelper.parseInt(data['CreatedByUserID']),
      createdDateTime: data['CreatedDateTime'] != null ?ParsingHelper.splitTimePre(data['CreatedDateTime']) : null,
      lastUpdatedByUserId: ParsingHelper.parseInt(data['LastUpdatedByUserID']),
      lastUpdatedDateTime: data['LastUpdatedDateTime'] != null ? ParsingHelper.splitTimePre(data['LastUpdatedDateTime']) : null,
    );
  }
}

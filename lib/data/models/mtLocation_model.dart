import '../../core/utils/parsing_helper.dart';

class MTLocationModel {
  final int id;
  final int? mtLocationTypeId;
  final String? plantCode;
  final String? name;
  final String? address;
  final String? latitude;
  final String? longitude;
  final int? geoFence;
  final int? createdByUserId;
  final bool? isActive;
  final String? createdDateTime;
  final int? lastUpdatedByUserId;
  final String? lastUpdatedDateTime;

  MTLocationModel({
    required this.id,
    this.mtLocationTypeId,
    this.plantCode,
    this.name,
    this.isActive,
    this.address,
    this.latitude,
    this.longitude,
    this.geoFence,
    this.createdByUserId,
    this.createdDateTime,
    this.lastUpdatedByUserId,
    this.lastUpdatedDateTime,
  });

  factory MTLocationModel.fromJson(Map<String, dynamic> data) {
    return MTLocationModel(
      id: ParsingHelper.parseInt(data['ID']) ?? 0,
      mtLocationTypeId: ParsingHelper.parseInt(data['MTLocationTypeID']),
      plantCode: data['PlantCode'],
      name: data['Name'],
      address: data['Address'],
      latitude: data['Latitude'],
      isActive:ParsingHelper.parseBool(data['IsActive']),
      longitude: data['Longitude'],
      geoFence: ParsingHelper.parseInt(data['GeoFence']),
      createdByUserId: ParsingHelper.parseInt(data['CreatedByUserID']),
      createdDateTime: data['CreatedDateTime'] != null ? ParsingHelper.splitTimePre(data['CreatedDateTime']) : null,
      lastUpdatedByUserId: ParsingHelper.parseInt(data['LastUpdatedByUserID']),
      lastUpdatedDateTime: data['LastUpdatedDateTime'] != null ? ParsingHelper.splitTimePre(data['LastUpdatedDateTime']) : null,
    );
  }
}

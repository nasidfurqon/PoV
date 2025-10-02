import '../../core/utils/parsing_helper.dart';

class MTLocationModel {
  final int? id;
  final String? mtLocationTypeId;
  final String? plantCode;
  final String? name;
  final String? address;
  final String? latitude;
  final String? longitude;
  final String? geoFence;
  final String? createdByUserId;
  final bool? isActive;
  final String? createdDateTime;
  final String? lastUpdatedByUserId;
  final String? lastUpdatedDateTime;

  MTLocationModel({
    this.id,
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
      mtLocationTypeId: (data['MTLocationTypeID']).toString(),
      plantCode: data['PlantCode'],
      name: data['Name'],
      address: data['Address'],
      latitude: data['Latitude'],
      isActive:ParsingHelper.parseBool(data['IsActive']),
      longitude: data['Longitude'],
      geoFence: (data['GeoFence']).toString(),
      createdByUserId: (data['CreatedByUserID']).toString(),
      createdDateTime: data['CreatedDateTime'] != null ? ParsingHelper.splitTimePre(data['CreatedDateTime']) : null,
      lastUpdatedByUserId: (data['LastUpdatedByUserID']).toString(),
      lastUpdatedDateTime: data['LastUpdatedDateTime'] != null ? ParsingHelper.splitTimePre(data['LastUpdatedDateTime']) : null,
    );
  }

  factory MTLocationModel.convertToModel(
      MTLocationModel current, Map<String, dynamic> data) {
    return MTLocationModel(
      mtLocationTypeId: (data['MTLocationTypeID'] ?? current.mtLocationTypeId).toString(),
      plantCode: data['PlantCode'] ?? current.plantCode,
      name: data['Name'] ?? current.name,
      address: data['Address'] ?? current.address,
      latitude: data['Latitude'] ?? current.latitude,
      longitude: data['Longitude'] ?? current.longitude,
      isActive: ParsingHelper.parseBool(data['IsActive']) ?? current.isActive,
      geoFence: (data['GeoFence'] ?? current.geoFence).toString(),
      createdByUserId: (data['CreatedByUserID'] ?? current.createdByUserId).toString(),
      createdDateTime: data['CreatedDateTime'] ?? current.createdDateTime,
      lastUpdatedByUserId: (data['LastUpdatedByUserID'] ?? current.lastUpdatedByUserId).toString(),
      lastUpdatedDateTime: data['LastUpdatedDateTime'] ?? current.lastUpdatedDateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MTLocationTypeID': mtLocationTypeId ?? '',
      'PlantCode': plantCode ?? '',
      'Name': name ?? '',
      'Address': address ?? '',
      'Latitude': latitude ?? '',
      'Longitude': longitude ?? '',
      'IsActive': isActive ?? '',
      'GeoFence': geoFence ?? '',
      'CreatedByUserID': createdByUserId ?? '',
      'CreatedDateTime': createdDateTime ?? '',
      'LastUpdatedByUserID': lastUpdatedByUserId ?? '',
      'LastUpdatedDateTime': lastUpdatedDateTime ?? '',
    };
  }
}

import 'package:pov2/core/utils/parsing_helper.dart';

class JobListModel {
  final int? trVisitationScheduleID;
  final int? locationID;
  final int? userID;
  final String? locationName;
  final String? longitude;
  final String? latitude;
  final String? scheduleStatus;
  final String? schedulePriority;
  final String? fullName;
  final String? locationAddress;
  final String? visitationDescription;
  final String? startDateTime;
  final String? endDateTime;
  final String? geofence;
  final String? actualStartDateTime;
  JobListModel(
  {
    this.trVisitationScheduleID, this.actualStartDateTime, this.locationID, this.userID, this.locationName, this.longitude, this.latitude, this.scheduleStatus, this.schedulePriority, this.fullName, this.locationAddress, this.visitationDescription, this.startDateTime, this.endDateTime, this.geofence
  });

  factory JobListModel.fromJson(Map<String, dynamic> data) {
    return JobListModel(
      trVisitationScheduleID: ParsingHelper.parseInt(data['TRVisitationScheduleID']),
      locationID: ParsingHelper.parseInt(data['LocationID']),
      userID: ParsingHelper.parseInt(data['UserID']),
      locationName: data['LocationName']?.toString(),
      longitude: data['Longitude']?.toString(),
      latitude: data['Latitude']?.toString(),
      scheduleStatus: data['ScheduleStatus']?.toString(),
      schedulePriority: data['SchedulePriority']?.toString(),
      fullName: data['FullName']?.toString(),
      locationAddress: data['LocationAddress']?.toString(),
      visitationDescription: data['VisitationDescription']?.toString(),
      startDateTime: data['StartDateTime']?.toString(),
      endDateTime: data['EndDateTime']?.toString(),
      geofence: data['GeoFence']?.toString(),
      actualStartDateTime: data['ActualStartDateTime']?.toString()
    );
  }
}


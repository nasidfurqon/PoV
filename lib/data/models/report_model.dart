import 'package:pov2/core/utils/parsing_helper.dart';

class ReportModel{
  final String? year;
  final String? month;
  final int? totalComplete;
  final int? totalLocation;
  final bool? progress;

  ReportModel({this.year, this.month, this.totalComplete, this.totalLocation, this.progress});

  factory ReportModel.fromJson(Map<String, dynamic> data) {
    return ReportModel(
      year: (data['Year']).toString(),
      month: data['Month'].toString(),
      totalComplete: ParsingHelper.parseInt(data['TotalComplete']),
      totalLocation: ParsingHelper.parseInt(data['TotalLocation']),
      progress: ParsingHelper.parseBool(data['Progress']),
    );
  }
}
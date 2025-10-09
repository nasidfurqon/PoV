
import 'package:pov2/core/utils/parsing_helper.dart';

class DocumentationModel{
  final String? locationName;
  final String? date;
  final String? totalSizePhoto;
  final String? totalSizeDocument;
  final String? totalSizeVideo;
  final String? type;

  DocumentationModel(
      {this.locationName, this.date, this.type, this.totalSizePhoto, this.totalSizeDocument, this.totalSizeVideo});

  factory DocumentationModel.fromJson(Map<String, dynamic> data) {
    return DocumentationModel(
      locationName: data['LocationName'],
      date: ParsingHelper.splitTimePre(data['LatestCreated']),
      totalSizePhoto: data['TotalPhotoSize'],
      totalSizeDocument: data['TotalDocumentSize'],
      type: data['Type'],
      totalSizeVideo: data['TotalVideoSize']
    );
  }
}
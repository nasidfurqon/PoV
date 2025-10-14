import 'package:pov2/core/utils/parsing_helper.dart';

class MTVisitationPurpose{
  final int? id;
  final String? code;
  final String? name;
  final String? remark;

  MTVisitationPurpose({this.id, this.code, this.name, this.remark});

  factory MTVisitationPurpose.fromJson(Map<String, dynamic> data) {
    return MTVisitationPurpose(
      id: ParsingHelper.parseInt(data['ID']),
      code: (data['Code']).toString(),
      name: data['Name'].toString(),
      remark: data['Remark'].toString(),
    );
  }
}
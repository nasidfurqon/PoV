import 'dart:convert';

import 'package:http/http.dart';
import 'package:pov2/data/models/mtLocation_model.dart';
import 'package:pov2/data/models/trVisitationSchedule_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/config.dart';
class UpdateService {
  static Future<bool> trVisitationSchedule(dynamic ID,Map<String, dynamic> data) async{
    var pref = await SharedPreferences.getInstance();
    try {
      Response response = await post(
          Uri.parse(
              '${AppConfig.serverAddress}/api/edit/TRVisitationSchedule/${ID}'),
          headers: {
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}'
          },
          body: data
      );
      print('RESPONSE EDIT API TR VISITATION SCHEDULE: ${response.body}, CODE = ${response.statusCode}');
      if(response.statusCode == 200){
        return true;
      }
      else{
        return false;
      }
    }
    catch(e){
      print('RESPONSE EDIT API TR VISITATION SCHEDULE FAILED : $e');
      return false;
    }
  }
}
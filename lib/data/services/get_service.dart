import 'dart:convert';

import 'package:http/http.dart';
import 'package:pov2/data/models/mtLocation_model.dart';
import 'package:pov2/data/models/trVisitationSchedule_model.dart';
import '../../core/utils/config.dart';

class GetService{
  static String jwtToken = '';

  static Future<String> name(dynamic id) async{
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/view/MTUser/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer $jwtToken',
          });

      print("API RESPONSE CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['TableVar'];
        return res['UserName'];
      }
      else{
        return '';
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load user name, $e!");
      return '';
    }
  }

  static Future<List<TRVisitationScheduleModel>> getListScheduleToday(dynamic id) async{
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/filter/ScheduleToday/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer $jwtToken',
          });

      print("API RESPONSE LIST SCHEDULE TODAY CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res.map<TRVisitationScheduleModel>((item) => TRVisitationScheduleModel.fromJson(item)).toList();
      }
      else{
        return [];
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load list schedule today, $e!");
      return [];
    }
  }

  static Future<MTLocationModel?> getLocationbyID(dynamic id) async{
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/view/MTLocation/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer $jwtToken',
          });

      print("API RESPONSE GET LOCATION BY ID: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['TableVar'];
        return MTLocationModel.fromJson(res);
      }
      else{
        return null;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load location data, $e!");
      return null;
    }
  }
}
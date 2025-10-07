import 'dart:convert';

import 'package:http/http.dart';
import '../../core/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AddService {
  static Future<bool> trVisitationSchedule(Map<String, dynamic> data) async{
    var pref = await SharedPreferences.getInstance();
    try {
      Response response = await post(
          Uri.parse(
              '${AppConfig.serverAddress}/api/add/TRVisitationSchedule'),
          headers: {
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}'
          },
          body: data
      );
      print('RESPONSE ADD API TR VISITATION SCHEDULE: ${response.body}');
      if(response.statusCode == 200){
        return true;
      }
      else{
        return false;
      }
    }
    catch(e){
      print('RESPONSE ADD API TR VISITATION SCHEDULE FAILED : $e');
      return false;
    }
  }

  static Future<bool> mtLocation(Map<String, dynamic> data) async{
    var pref = await SharedPreferences.getInstance();
    try {
      Response response = await post(
          Uri.parse(
              '${AppConfig.serverAddress}/api/add/MTLocation'),
          headers: {
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}'
          },
          body: data
      );
      print('RESPONSE ADD API MT LOCATION SCHEDULE: ${response.body}');
      if(response.statusCode == 200){
        return true;
      }
      else{
        return false;
      }
    }
    catch(e){
      print('RESPONSE ADD API MT LOCATION SCHEDULE FAILED : $e');
      return false;
    }
  }
}
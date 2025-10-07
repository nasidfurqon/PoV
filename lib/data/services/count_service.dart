import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import '../../core/utils/config.dart';
class CountService{
  static Future<int> countStatus(String status, dynamic id) async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/count/TRVisitationSchedule/Status/$status/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API COUNT RESPONSE CHECK status $status: ${response.body} from user $id");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res;
      }
      else{
        return 0;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load count status, $e!");
      return 0;
    }
  }

  static Future<int> countLocation(dynamic id) async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/count/MTLocation/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API COUNT LOCATION RESPONSE CHECK : ${response.body} from user $id");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res;
      }
      else{
        return 0;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load count location, $e!");
      return 0;
    }
  }

  static Future<int> countActiveLocation(dynamic id) async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/count/MTLocationActive/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API COUNT Active LOCATION RESPONSE CHECK : ${response.body} from user $id");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res;
      }
      else{
        return 0;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load count active location, $e!");
      return 0;
    }
  }

  static Future<int> countTotalVisitation() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/count/TotalVisitation/${pref.getString('userId').toString()}'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API COUNT TOTAL VISITATION RESPONSE CHECK : ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res;
      }
      else{
        return 0;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load count total visitation, $e!");
      return 0;
    }
  }

  // ADMIN
  static Future<int> countAdminLocation() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/countAdmin/MTLocation'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API COUNT LOCATION RESPONSE CHECK : ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res;
      }
      else{
        return 0;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load count active location, $e!");
      return 0;
    }
  }

  static Future<int> countAdminActiveLocationActive() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/countAdmin/MTLocationActive'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API COUNT Active LOCATION RESPONSE CHECK : ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res;
      }
      else{
        return 0;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load count active location, $e!");
      return 0;
    }
  }

  static Future<int> countAdminUser() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/countAdmin/User/Active'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API COUNT Active USER RESPONSE CHECK : ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res;
      }
      else{
        return 0;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load count active location, $e!");
      return 0;
    }
  }

  static Future<int> countAdminScheduleToday() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/countAdmin/ScheduleToday'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API COUNT SCHEDULE TODAY RESPONSE CHECK : ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res;
      }
      else{
        return 0;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load count schedule today, $e!");
      return 0;
    }
  }

  static Future<int> countAdminScheduleTodayCompleted() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/countAdmin/ScheduleTodayCompleted'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API COUNT SCHEDULE TODAY COMPLETED RESPONSE CHECK : ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res;
      }
      else{
        return 0;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load count schedule today, $e!");
      return 0;
    }
  }

  static Future<int> countAdminTotalVisitation() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/countAdmin/TotalVisitation'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API COUNT TOTAL VISITATION RESPONSE CHECK : ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res;
      }
      else{
        return 0;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load count total visitation, $e!");
      return 0;
    }
  }
}
import 'dart:convert';

import 'package:pov2/data/models/trVisitationScheduleEvidence_model.dart';
import 'package:pov2/data/services/get_admin_service.dart';
import 'package:pov2/data/services/get_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import '../../core/utils/config.dart';
import '../../core/utils/file_helper.dart';
class CountService{
  static Future<int> countStatus(String status, dynamic id) async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/count/TRVisitationSchedule/Status/$status/$id'),
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
              '${AppConfig.serverAddress}/api/count/MTLocation/$id'),
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
              '${AppConfig.serverAddress}/api/count/MTLocationActive/$id'),
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
              '${AppConfig.serverAddress}/api/count/TotalVisitation/${pref.getString('userId').toString()}'),
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
              '${AppConfig.serverAddress}/api/countAdmin/MTLocation'),
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
              '${AppConfig.serverAddress}/api/countAdmin/MTLocationActive'),
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
              '${AppConfig.serverAddress}/api/countAdmin/User/Active'),
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
              '${AppConfig.serverAddress}/api/countAdmin/ScheduleToday'),
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
              '${AppConfig.serverAddress}/api/countAdmin/ScheduleTodayCompleted'),
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
              '${AppConfig.serverAddress}/api/countAdmin/TotalVisitation'),
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

  static Future<int> countAdminTotalVisitationCompleted() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/countAdmin/TotalVisitationCompleted'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API COUNT TOTAL VISITATION COMPLETED RESPONSE CHECK : ${response.body}");
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
      print("API RESPONSE FAILED: Failed to load count total visitation completed, $e!");
      return 0;
    }
  }

  static Future<int> countAdminTotalVisitationCurrentMonth() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/countAdmin/TotalVisitationCurrentMonth'),
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

  static Future<int> countAdminTotalVisitationCurrentMonthCompleted() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/countAdmin/TotalVisitationCompletedCurrentMonth'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API COUNT TOTAL VISITATION COMPLETED RESPONSE CHECK : ${response.body}");
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
      print("API RESPONSE FAILED: Failed to load count total visitation completed, $e!");
      return 0;
    }
  }

  static Future<int> countAdminTotalDocument(String type) async{
    try{
      List<TRVisitationScheduleEvidenceModel> listEvidence = await GetAdminService.getListEvidence();
      int total = listEvidence.where((evidence) {
        final kategori = FileHelper.getCategory(evidence.attachment ?? "");
        return kategori.toLowerCase() == type.toLowerCase();
      }).length;

      return total;
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load count total visitation completed, $e!");
      return 0;
    }
  }
}
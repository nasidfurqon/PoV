import 'dart:convert';

import 'package:pov2/data/models/mtLocationType_model.dart';
import 'package:pov2/data/models/mtLocation_model.dart';
import 'package:pov2/data/models/mtUser_model.dart';
import 'package:pov2/data/models/report_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/config.dart';
import '../models/trVisitationSchedule_model.dart';
import 'package:http/http.dart';

class GetAdminService{
  static Future<List<TRVisitationScheduleModel>> getListScheduleToday() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/filterAdmin/ScheduleToday'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
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

  static Future<List<TRVisitationScheduleModel>> getListScheduleTodayCompleted() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/filterAdmin/ScheduleTodayCompleted'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST SCHEDULE TODAY Completed CHECK: ${response.body}");
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
      print("API RESPONSE FAILED: Failed to load list schedule completed today, $e!");
      return [];
    }
  }

  static Future<List<TRVisitationScheduleModel>> getListSchedule() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/list/TRVisitationSchedule'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST SCHEDULE TODAY CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['TRVisitationSchedule'];
        return res.map<TRVisitationScheduleModel>((item) => TRVisitationScheduleModel.fromJson(item)).toList();
      }
      else{
        return [];
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load list schedule, $e!");
      return [];
    }
  }

  static Future<List<MTLocationModel>> getListLocation() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/list/MTLocation'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST Location CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['MTLocation'];
        return res.map<MTLocationModel>((item) => MTLocationModel.fromJson(item)).toList();
      }
      else{
        return [];
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load list location, $e!");
      return [];
    }
  }

  static Future<List<MTLocationTypeModel>> getListLocationType() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/list/MTLocationType'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST Location TYPE CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['MTLocationType'];
        return res.map<MTLocationTypeModel>((item) => MTLocationTypeModel.fromJson(item)).toList();
      }
      else{
        return [];
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load list location type, $e!");
      return [];
    }
  }

  static Future<List<MTUserModel>> getListUser() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/filterAdmin/listUser'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST user CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res.map<MTUserModel>((item) => MTUserModel.fromJson(item)).toList();
      }
      else{
        return [];
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load list user, $e!");
      return [];
    }
  }

  static Future<List<ReportModel>> getListReport() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/filterAdmin/Report'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST REPORT CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res.map<ReportModel>((item) => ReportModel.fromJson(item)).toList();
      }
      else{
        return [];
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load list report, $e!");
      return [];
    }
  }
}
import 'dart:convert';

import 'package:http/http.dart';
import 'package:pov2/data/models/mtLocationType_model.dart';
import 'package:pov2/data/models/mtLocation_model.dart';
import 'package:pov2/data/models/mtUserPosition_model.dart';
import 'package:pov2/data/models/mtUser_model.dart';
import 'package:pov2/data/models/trVisitationSchedule_model.dart';
import '../../core/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GetService{
  static Future<String> name(dynamic id) async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/view/MTUser/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
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
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/filter/ScheduleToday/$id'),
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

  static Future<List<TRVisitationScheduleModel>> getListCompletedSchedule(dynamic id) async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/filter/ScheduleCompleted/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST SCHEDULE COMPLETED CHECK: ${response.body}");
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
      print("API RESPONSE FAILED: Failed to load list schedule completed, $e!");
      return [];
    }
  }

  static Future<List<TRVisitationScheduleModel>> getListSchedule(dynamic id) async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/filter/TRVisitationSchedule/MTAssignedUserID/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST SCHEDULE CHECK: ${response.body}");
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
      print("API RESPONSE FAILED: Failed to load list schedule , $e!");
      return [];
    }
  }

  static Future<TRVisitationScheduleModel?> getScheduleByID(dynamic id) async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/view/TRVisitationSchedule/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE GET TR VISITATION SCHEDULE BY ID: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['TableVar'];
        return TRVisitationScheduleModel.fromJson(res);
      }
      else{
        return null;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load TR VISITATION SCHEDULE  data, $e!");
      return null;
    }
  }

  static Future<MTLocationModel?> getLocationbyID(dynamic id) async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/view/MTLocation/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
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

  static Future<List<MTLocationModel>> getListLocation() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/list/MTLocation'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST LOCATION CHECK: ${response.body}");
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
      print("API RESPONSE FAILED: Failed to load list location , $e!");
      return [];
    }
  }

  static Future<MTLocationTypeModel?> getLocationType(dynamic id) async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/view/MTLocationType/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LOCATION TYPE CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['TableVar'];
        return MTLocationTypeModel.fromJson(res);
      }
      else{
        return null;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load location type, $e!");
      return null;
    }
  }

  static Future<MTUserModel?> getUser(dynamic id) async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/view/MTUser/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE USER CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['TableVar'];
        return MTUserModel.fromJson(res);
      }
      else{
        return null;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load user, $e!");
      return null;
    }
  }

  static Future<MTUserPositionModel?> getUserPosition(dynamic id) async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              'http://${AppConfig.serverAddress}/api/view/MTUserPosition/$id'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE USER POSITION CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['TableVar'];
        return MTUserPositionModel.fromJson(res);
      }
      else{
        return null;
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load user position data, $e!");
      return null;
    }
  }
}
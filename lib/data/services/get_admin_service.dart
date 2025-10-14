import 'dart:convert';

import 'package:pov2/data/models/documentation_model.dart';
import 'package:pov2/data/models/mtLocationType_model.dart';
import 'package:pov2/data/models/mtLocation_model.dart';
import 'package:pov2/data/models/mtUser_model.dart';
import 'package:pov2/data/models/report_model.dart';
import 'package:pov2/data/models/trVisitationScheduleEvidence_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/config.dart';
import '../../core/utils/file_helper.dart';
import '../models/jobList_model.dart';
import '../models/mtVisitationPurpose_model.dart';
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

  static Future<List<MTVisitationPurpose>> getListVisitationPurpose() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/list/MTVisitationPurpose'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST MTVisitationPurpose TYPE CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['MTVisitationPurpose'];
        return res.map<MTVisitationPurpose>((item) => MTVisitationPurpose.fromJson(item)).toList();
      }
      else{
        return [];
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load list MTVisitationPurpose type, $e!");
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

  static Future<List<TRVisitationScheduleEvidenceModel>> getListEvidence() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/list/TRVisitationScheduleEvidence'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST TRVisitationScheduleEvidenceModel CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['TRVisitationScheduleEvidence'];
        return res.map<TRVisitationScheduleEvidenceModel>((item) => TRVisitationScheduleEvidenceModel.fromJson(item)).toList();
      }
      else{
        return [];
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load list visitation schedule model, $e!");
      return [];
    }
  }

  static Future<Map<String, List<TRVisitationScheduleEvidenceModel>>> getEvidenceByCategoryAndSchedule() async{
    final Map<String, List<TRVisitationScheduleEvidenceModel>> grouped = {};
    List<TRVisitationScheduleEvidenceModel> data = await GetAdminService.getListEvidence();

    for (var item in data) {
      final category = FileHelper.getCategory(item.attachment ?? "");
      final scheduleId = item.trVisitationScheduleId ?? "";

      final key = "$scheduleId-$category";

      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(item);
    }
    return grouped;
  }

  static Future<List<JobListModel>> getListJob() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/filterAdmin/JobList'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST JOB CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res.map<JobListModel>((item) => JobListModel.fromJson(item)).toList();
      }
      else{
        return [];
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load list job , $e!");
      return [];
    }
  }

  static Future<List<JobListModel>> getListJobCompleted() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/filterAdmin/JobListCompleted'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST JOB completed CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res.map<JobListModel>((item) => JobListModel.fromJson(item)).toList();
      }
      else{
        return [];
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load list job completed , $e!");
      return [];
    }
  }

  static Future<List<JobListModel>> getListJobToday() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/filterAdmin/JobListToday'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST JOB TODAY CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res.map<JobListModel>((item) => JobListModel.fromJson(item)).toList();
      }
      else{
        return [];
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load list job today , $e!");
      return [];
    }
  }

  static Future<List<JobListModel>> getListJobTodayCompleted() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/filterAdmin/JobListTodayCompleted'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST JOB TODAY COMPLETED CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res.map<JobListModel>((item) => JobListModel.fromJson(item)).toList();
      }
      else{
        return [];
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load list job today completed , $e!");
      return [];
    }
  }

  static Future<List<DocumentationModel>> getListDocumentation() async{
    var pref = await SharedPreferences.getInstance();
    try{
      Response response = await get(
          Uri.parse(
              '${AppConfig.serverAddress}/api/filterAdmin/documentationDataAll'),
          headers: <String, String>{
            'Authorization': 'Bearer ${pref.getString('jwtToken') ?? ''}',
          });

      print("API RESPONSE LIST DOCUMENTATION CHECK: ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final res = data['data'];
        return res.map<DocumentationModel>((item) => DocumentationModel.fromJson(item)).toList();
      }
      else{
        return [];
      }
    }
    catch(e){
      print("API RESPONSE FAILED: Failed to load list documentation model, $e!");
      return [];
    }
  }
}
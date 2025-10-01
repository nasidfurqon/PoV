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
      print("API RESPONSE FAILED: Failed to load user name, $e!");
      return 0;
    }
  }
}
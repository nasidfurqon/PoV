import 'dart:convert';

import 'package:http/http.dart';
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
}
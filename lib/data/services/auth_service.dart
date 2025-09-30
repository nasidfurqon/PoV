import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/utils/config.dart';

class AuthService{
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('http://${AppConfig.serverAddress}/api/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body:{
        'username': email,
        'password': password,
      },
    );
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : {};
    if (response.statusCode == 200) {
      return {
        'success': true,
        ...body,
      };
    } else {
      return {
        'success': false,
        'message': body is Map && body['message'] != null
            ? body['message']
            : response.body,
      };
    }
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pov2/data/models/mtUser_model.dart';
import 'package:pov2/data/services/user_notifier.dart';
import '../../core/utils/config.dart';

class AuthService{
  static Future<Map<String, dynamic>> login(WidgetRef ref, String email, String password) async {
    final url = Uri.parse('${AppConfig.serverAddress}/api/login');
    print("CEK LOGIN");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body:{
        'username': email,
        'password': password,
      },
    );
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : {};
    print("RESPONSE API LOGIN SERVICE: $body");
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
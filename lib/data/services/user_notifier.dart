import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pov2/data/models/mtUser_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final userProvider = NotifierProvider<UserNotifier, MTUserModel?>(
  UserNotifier.new
);

class UserNotifier extends Notifier<MTUserModel?>{

  @override
  MTUserModel? build() => null;

  Future<void> login(MTUserModel user) async{
    print('CEK FROM PROVIDER ${user.email}');
    state = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', jsonEncode(user.toJson()));
  }

  Future<void> loadUserFromStorage() async{
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('userData');
    if(jsonString != null){
      state = MTUserModel.fromJson(jsonDecode(jsonString));
    }
  }

  Future<void> logout() async{
    state = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
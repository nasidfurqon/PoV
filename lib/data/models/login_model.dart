import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginModel {
  final String email;
  final String password;

  const LoginModel({
    required this.email,
    required this.password,
  });

  LoginModel copyWith({
    String? email,
    String? password,
  }) {
    return LoginModel(
        email: email ?? this.email,
        password: password ?? this.password,
    );
  }
}

class LoginProvider extends StateNotifier<LoginModel> {
  LoginProvider() : super(const LoginModel(email: '', password: ''));

  void setUsername(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }
}
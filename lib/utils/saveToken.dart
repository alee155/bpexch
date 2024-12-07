import 'dart:convert';

import 'package:bpexch/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
  print('#########Token saved successfully: ${prefs.getString('auth_token')}');
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

Future<void> saveUser(UserModel user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_data', json.encode(user.toJson()));
}

Future<UserModel?> getUser() async {
  final prefs = await SharedPreferences.getInstance();
  final userData = prefs.getString('user_data'); // Get the saved user data
  if (userData != null) {
    return UserModel.fromJson(
        json.decode(userData)); // Deserialize the user data
  }
  return null; // Return null if no user data is found
}


Future<void> clearUserData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
  await prefs.remove('user_data');
}

import 'dart:convert';

import 'package:bpexch/model/login_response_model.dart';
import 'package:bpexch/utils/saveToken.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<LoginResponseModel?> loginUser(
      String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://bpexchdeals.com/api/login'),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['token'];

        // Save the token and user data
        await saveToken(token); // Save token
        print('**********Token saved**********: $token');

        // Create a LoginResponseModel from the response
        final loginResponse = LoginResponseModel.fromJson(responseData);

        // Save the user data
        await saveUser(loginResponse.user); // Save user data
        print('**********User saved**********: ${loginResponse.user.name}');

        return loginResponse; // Return the LoginResponseModel
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}

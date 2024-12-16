import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogoService {
  // Fetch and save company logo
  Future<void> fetchAndSaveCompanyLogo() async {
    const url = 'https://bpexchdeals.com/api/get_company_logo';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({}),
      );

      if (response.statusCode == 200) {
        if (response.headers['content-type']?.startsWith('image/') ?? false) {
          // Save the logo in shared preferences as a base64 string
          final imageBytes = response.bodyBytes;
          String base64String = base64Encode(imageBytes);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('company_logo', base64String);

          print('*************Logo saved in SharedPreferences*************');
          print('*************Company Logo Base64: $base64String*************');
        } else {
          print('Response data (not an image): ${response.body}');
        }
      } else {
        print(
            'Failed to load company logo. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching company logo: $e');
    }
  }
}

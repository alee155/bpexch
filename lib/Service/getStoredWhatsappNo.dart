import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TimeService {
  // Function to call the API and store the whatsapp_no in SharedPreferences
  Future<void> fetchTime() async {
    const url = 'https://bpexchdeals.com/api/getTime';

    try {
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        // Print the response body if status code is 200
        print('*******Get Time API Response: ${response.body}');

        // Parse the response and store the whatsapp_no in SharedPreferences
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 200) {
          var whatsappNo = responseData['Data'][0]['whatsapp_no'];
          await saveWhatsappNo(whatsappNo);
          print('*******Stored WhatsApp Number: $whatsappNo');
        }
      } else {
        // Handle non-200 status codes
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  // Function to save the whatsapp_no in SharedPreferences
  Future<void> saveWhatsappNo(String whatsappNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('whatsapp_no', whatsappNo);
  }

  // Function to get the stored whatsapp_no from SharedPreferences
  Future<String?> getStoredWhatsappNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? whatsappNo = prefs.getString('whatsapp_no');
    if (whatsappNo != null) {
      print('*******Retrieved WhatsApp Number: $whatsappNo');
      return whatsappNo;
    } else {
      print('*******No WhatsApp number stored.');
      return null;
    }
  }
}

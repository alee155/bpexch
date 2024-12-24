// time_api.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TimeAPI {
  static Future<Map<String, dynamic>> fetchTime() async {
    final url = Uri.parse('https://bpexchdeals.com/api/getTime');
    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        String currentTime = data['currentTime'] ?? '';
        String fromTime = data['Data'][0]['from_time'] ?? '';
        String toTime = data['Data'][0]['to_time'] ?? '';
        bool isWithinRange = data['isWithinRange'] ?? false;

        DateTime parsedCurrentTime = DateFormat('HH:mm:ss').parse(currentTime);
        String formattedCurrentTime =
            DateFormat('hh:mm a').format(parsedCurrentTime);

        DateTime parsedFromTime = DateFormat('HH:mm:ss').parse(fromTime);
        DateTime parsedToTime = DateFormat('HH:mm:ss').parse(toTime);

        String formattedFromTime = DateFormat('hh:mm a').format(parsedFromTime);
        String formattedToTime = DateFormat('hh:mm a').format(parsedToTime);

        return {
          'formattedFromTime': formattedFromTime,
          'formattedToTime': formattedToTime,
          'isWithinRange': isWithinRange,
        };
      } else {
        throw Exception("Error fetching time: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error: $error");
    }
  }
}

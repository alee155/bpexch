import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TimeHelper {
  // Method to get the time and check if the current time is within the allowed range
  static Future<Map<String, dynamic>> validateTime(String currentTime) async {
    try {
      // Step 1: Make the POST API call to get the time
      final response = await http.post(
        Uri.parse('https://bpexchdeals.com/api/getTime'),
      );

      // Step 2: Handle the response
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final result = responseData['result'];

        if (result == true) {
          final List<dynamic> data = responseData['Data'] ?? [];
          if (data.isNotEmpty) {
            final timeData =
                data[0]; // Assuming we are only dealing with the first item
            final fromTime = timeData['from_time'] ?? '';
            final toTime = timeData['to_time'] ?? '';
            final errorMessage = responseData['error'] ?? 'An error occurred';

            // Step 3: Compare currentTime with from_time and to_time
            if (_isCurrentTimeBetween(fromTime, toTime, currentTime)) {
              return {
                'isWithinRange': true,
                'message':
                    'Current time is within the valid range ($fromTime to $toTime).',
              };
            } else {
              return {
                'isWithinRange': false,
                'message':
                    'Current time is not within the valid range ($fromTime to $toTime). $errorMessage',
              };
            }
          } else {
            return {
              'isWithinRange': false,
              'message': 'No valid data found in the response.',
            };
          }
        } else {
          return {
            'isWithinRange': false,
            'message': 'Error: ${responseData['error']}',
          };
        }
      } else {
        return {
          'isWithinRange': false,
          'message': 'Failed to load data from API.',
        };
      }
    } catch (e) {
      return {
        'isWithinRange': false,
        'message': 'An error occurred during the API call: $e',
      };
    }
  }

  // Method to check if the current time is between from_time and to_time
  static bool _isCurrentTimeBetween(
      String fromTime, String toTime, String currentTime) {
    final current = _parseTime(currentTime);
    final from = _parseTime(fromTime);
    final to = _parseTime(toTime);

    return current.isAfter(from) && current.isBefore(to);
  }

  // Method to convert a time string to a DateTime object
  static DateTime _parseTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final second = int.parse(parts[2]);
    return DateTime(0, 0, 0, hour, minute, second); // Using a dummy date
  }

  // Method to show error dialog with a message
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

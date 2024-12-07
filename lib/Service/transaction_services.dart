import 'dart:convert';

import 'package:bpexch/model/transaction_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Transaction>> fetchTransactionHistory(int userId) async {
  const String apiUrl = 'https://bpexchdeals.com/api/transaction_history';

  try {
    // Get the token from shared preferences
    final token = await getToken();
    if (token == null) {
      throw Exception('No token found. Please login again.');
    }

    // Prepare the headers with the Authorization Bearer token
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // Make the API call
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: json.encode({'user_id': userId}),
    );

    // Log the response for debugging
    print(
        '********************API Response: ${response.body} ********************');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Check for success in response
      if (responseData['status'] == 200 && responseData['result'] == true) {
        final List<dynamic> transactionsJson = responseData['data'];
        return transactionsJson
            .map((json) => Transaction.fromJson(json))
            .toList();
      } else {
        throw Exception(responseData['message'] ?? 'Unknown error occurred');
      }
    } else {
      throw Exception(
          'Failed to fetch transaction history. Status Code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error during API call: $error');
    throw Exception('Failed to fetch transaction history: $error');
  }
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

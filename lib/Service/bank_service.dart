import 'dart:convert';

import 'package:bpexch/model/GetBank_Model/bank_model.dart';
import 'package:http/http.dart' as http;

class BankService {
  // Function to fetch the list of banks
  Future<List<Bank>> fetchBanks(String token) async {
    final response = await http.get(
      Uri.parse('https://bpexchdeals.com/api/get_banks_name'),
      headers: {
        'Authorization': 'Bearer $token', // Pass the Bearer token
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // Check if the response has a valid 'data' field and parse it
      if (responseData['status'] == 200 && responseData['data'] != null) {
        List<dynamic> banksJson = responseData['data'];
        return banksJson.map((bankJson) => Bank.fromJson(bankJson)).toList();
      } else {
        throw Exception('Failed to load bank data');
      }
    } else {
      throw Exception('Failed to connect to the server');
    }
  }
}

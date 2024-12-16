import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/faq_model.dart';

class FaqService {
  static const String apiUrl = 'https://bpexchdeals.com/api/getFaq';

  static Future<List<Faq>> fetchFaqs() async {
    try {
      final response = await http.post(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['result'] == true && data['activeFaq'] != null) {
          return List<Faq>.from(
            data['activeFaq'].map((faq) => Faq.fromJson(faq)),
          );
        } else {
          return [];
        }
      } else {
        throw Exception(
            'Failed to load FAQs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching FAQs: $e');
    }
  }
}

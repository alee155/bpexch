import 'dart:convert';

import 'package:bpexch/utils/companyInfo_save.dart';
import 'package:http/http.dart' as http;

class CompanyInfoService {
  Future<String?> fetchCompanyInfo() async {
    final response = await http
        .post(Uri.parse('https://bpexchdeals.com/api/get_company_info'));

    if (response.statusCode == 200) {
      // Decode the response and extract companyInfo
      var data = jsonDecode(response.body);
      String companyName = data['companyInfo'];
      print('************Company Info: $data');

      // Store the companyInfo in SharedPreferences
      await SharedPreferencesService().saveCompanyInfo(companyName);

      return companyName;
    } else {
      print('Failed to fetch company info');
      return null;
    }
  }
}

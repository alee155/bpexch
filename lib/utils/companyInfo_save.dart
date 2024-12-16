import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  // Key for companyInfo
  static const String _companyInfoKey = 'companyInfo';

  // Save company info to SharedPreferences
  Future<void> saveCompanyInfo(String companyInfo) async {
    final prefs = await SharedPreferences.getInstance();
    print('************Saving company info: $companyInfo');
    bool success = await prefs.setString(_companyInfoKey, companyInfo);

    if (success) {
      print('************Company info saved successfully');
    } else {
      print('************Failed to save company info');
    }
  }

  // Retrieve company info from SharedPreferences
  Future<String?> getCompanyInfo() async {
    final prefs = await SharedPreferences.getInstance();

    String? storedCompanyInfo = prefs.getString(_companyInfoKey);
    if (storedCompanyInfo != null) {
      print('************Stored Company Info: $storedCompanyInfo');
    } else {
      print('************No company info found in SharedPreferences');
    }

    return storedCompanyInfo;
  }
}

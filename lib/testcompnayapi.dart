import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CompanyInfoScreen extends StatefulWidget {
  const CompanyInfoScreen({super.key});

  @override
  _CompanyInfoScreenState createState() => _CompanyInfoScreenState();
}

class _CompanyInfoScreenState extends State<CompanyInfoScreen> {
  late Future<String?> _companyInfo;

  @override
  void initState() {
    super.initState();
    // Fetching company info with the name "BP Exchange"
    _companyInfo = ApiService().getCompanyInfo("BP Exchange");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Company Info')),
      body: FutureBuilder<String?>(
        future: _companyInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No company info found'));
          }

          final companyInfo = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const Text(
                  'Company Info',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'Company Name: $companyInfo',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                // Additional company details (Placeholder for now)
                const Text(
                  'Phone: 0300-9999999',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'Email: naqvi@solutionswave.com',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'Address: Johr Town, Libert Market',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'Website: bpexchdeals.com',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'State: Punjab',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'Country: USA',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'Currency: USD',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'For more details, contact us or visit our website.',
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ApiService {
  static const String _url = "https://bpexchdeals.com/api/get_company_info";

  // Function to fetch company info based on the name parameter
  Future<String?> getCompanyInfo(String name) async {
    final response = await http.post(
      Uri.parse(_url),
      body: {"name": name}, // Passing name parameter in the body
    );

    print("Response body: ${response.body}"); // Log the raw response body

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Decoded data: $data"); // Log the decoded data

      // Check if the status is 200 and if companyInfo is available
      if (data['status'] == 200 && data['companyInfo'] != null) {
        return data['companyInfo']; // Return companyInfo (e.g., "BP Exchange")
      } else {
        print("Company info is not available or status is not 200");
        return null;
      }
    } else {
      throw Exception('Failed to load company info');
    }
  }
}

class User {
  final String id;
  final String name;
  final String website;
  final String phone;
  final String email;
  final String address;
  final String addressTwo;
  final String state;
  final String country;
  final String currency;
  final String fiscalYear;

  User({
    required this.id,
    required this.name,
    required this.website,
    required this.phone,
    required this.email,
    required this.address,
    required this.addressTwo,
    required this.state,
    required this.country,
    required this.currency,
    required this.fiscalYear,
  });

  // Factory constructor to parse the JSON response into a User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      website: json['website'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      addressTwo: json['address_two'],
      state: json['state'],
      country: json['country'],
      currency: json['currency'],
      fiscalYear: json['fiscal_year'],
    );
  }
}

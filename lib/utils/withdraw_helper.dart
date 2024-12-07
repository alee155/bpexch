import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

import '../Service/toast_service.dart';
import '../utils/saveToken.dart';
import '../widgets/confirmation_dialog.dart';

class WithdrawHelper {
  static Future<void> handleWithdraw({
    required BuildContext context,
    required TextEditingController amountController,
    required TextEditingController accountDetailsController,
    required String paymentMethod,
    required VoidCallback onSuccess,
  }) async {
    final amount = amountController.text.trim();
    final accountDetails = accountDetailsController.text.trim();

    // Validation
    if (amount.isEmpty || paymentMethod.isEmpty || accountDetails.isEmpty) {
      String message = 'Please fill all the fields.';
      if (amount.isEmpty)
        message = 'Amount to withdraw is required.';
      else if (paymentMethod.isEmpty)
        message = 'Please select a payment method.';
      else if (accountDetails.isEmpty)
        message = 'Account details are required.';

      ToastService.showToast(
        context: context,
        title: 'Oops',
        message: message,
        type: ToastificationType.error,
      );
      return;
    }

    // Show confirmation dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: "Confirmation",
        content: "Are you sure to perform this transaction?",
        confirmText: "Yes",
        cancelText: "No",
        onConfirm: () => Navigator.pop(context, true),
        onCancel: () => Navigator.pop(context, false),
      ),
    );

    if (confirm != true) return; // Exit if user cancels

    try {
      // Fetch the stored token
      final token = await getToken();
      if (token == null) {
        ToastService.showToast(
          context: context,
          title: 'Error',
          message: 'User token is missing. Please login again.',
          type: ToastificationType.error,
        );
        return;
      }

      // API endpoint
      const String url = 'https://bpexchdeals.com/api/payment';

      // Request body
      final body = {
        'type': '2',
        'payment': amount,
        'payment_method': paymentMethod,
        'account': '12345', // Fixed value as per requirements
        'description': accountDetails,
      };

      // Request headers
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      // Handle the response
      if (response.statusCode == 200) {
        // Decode and print the response
        final responseData = json.decode(response.body);
        print('Response: $responseData');

        // Show success dialog
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Success",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold)),
            content: Text(
              "Your request is successfully submitted.\n"
              "Once the request is approved, the desired amount will be deducted from your wallet and sent to the beneficiary account.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  onSuccess(); // Call the success callback
                },
                child: Text("Ok",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      } else {
        final errorResponse = json.decode(response.body);
        ToastService.showToast(
          context: context,
          title: 'Error',
          message: errorResponse['message'] ?? 'Something went wrong.',
          type: ToastificationType.error,
        );
      }
    } catch (e) {
      ToastService.showToast(
        context: context,
        title: 'Error',
        message: 'An error occurred. Please try again.',
        type: ToastificationType.error,
      );
      print('Error: $e');
    }
  }
}

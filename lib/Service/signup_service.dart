// lib/services/signup_service.dart

import 'dart:convert';

import 'package:bpexch/Service/toast_service.dart';
import 'package:bpexch/auth/loginscreen.dart';
import 'package:bpexch/utils/apis_services/validators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

class SignupService {
  Future<void> handleSignUp(
    BuildContext context,
    String name,
    String username,
    String phoneNumber,
    String password,
    String confirmPassword,
  ) async {
    // Validate the form inputs
    final nameError = Validators.validateName(name);
    final usernameError = Validators.validateUsername(username);
    final phoneNumberError = Validators.validatePhoneNumber(phoneNumber);
    final passwordError = Validators.validatePassword(password);
    final confirmPasswordError =
        Validators.validateConfirmPassword(password, confirmPassword);

    // Collect the error messages
    List<String> errorMessages = [];

    if (nameError != null) errorMessages.add(nameError);
    if (usernameError != null) errorMessages.add(usernameError);
    if (phoneNumberError != null) errorMessages.add(phoneNumberError);
    if (passwordError != null) errorMessages.add(passwordError);
    if (confirmPasswordError != null) errorMessages.add(confirmPasswordError);

    // If there are any errors, show them in a SnackBar
    if (errorMessages.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              errorMessages.join('\n')), // Display each error in a new line
        ),
      );
      return;
    }

    // Create a dummy email from the username
    final email = "$username@bpexch.com";

    try {
      final response = await http.post(
        Uri.parse('https://bpexchdeals.com/api/register'),
        body: {
          'name': name,
          'username': username,
          'phone': phoneNumber,
          'password': password,
          'email': email, // Include the dummy email here
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['result'] == true) {
          // Success
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
          String toastTitle = 'Signup Success';
          String toastMessage =
              'Welcome! You have created account successfully.';
          ToastificationType toastType = ToastificationType.success;

          // Call the ToastService
          ToastService.showToast(
            context: context,
            title: toastTitle,
            message: toastMessage,
            type: toastType,
          );
        } else {
          String toastTitle = 'Failed';
          String toastMessage =
              'Failed to create user: ${responseData['message']}';
          ToastificationType toastType = ToastificationType.error;

          // Call the ToastService
          ToastService.showToast(
            context: context,
            title: toastTitle,
            message: toastMessage,
            type: toastType,
          );
        }
      } else {
        // HTTP error
        String toastTitle = 'Failed';
        String toastMessage = 'Failed to create user';
        ToastificationType toastType = ToastificationType.error;

        // Call the ToastService
        ToastService.showToast(
          context: context,
          title: toastTitle,
          message: toastMessage,
          type: toastType,
        );
      }
    } catch (e) {
      // Network or unexpected error
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create user")),
      );
    }
  }
}

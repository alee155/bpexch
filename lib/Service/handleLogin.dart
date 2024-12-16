// lib/utils/login_helper.dart
import 'package:bpexch/Service/login_service.dart';
import 'package:bpexch/Service/toast_service.dart';
import 'package:bpexch/auth/account_verification.dart';
import 'package:bpexch/utils/saveToken.dart';
import 'package:bpexch/view/BottomNavBar/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

Future<void> handleLogin(
  BuildContext context,
  String username,
  String password,
  LoginService loginService,
  TextEditingController usernameController,
  TextEditingController passwordController,
  Function setLoadingState,
) async {
  if (username.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill in all fields")),
    );
    return;
  }

  setLoadingState(true); // Show loading spinner

  try {
    final loginResponse = await loginService.loginUser(username, password);

    if (loginResponse != null) {
      // Convert the status to lowercase for case-insensitive comparison
      String userStatus = loginResponse.user.status.toLowerCase();

      // Save token and user data before navigating
      await saveToken(loginResponse.token); // Save the token
      await saveUser(loginResponse.user); // Save the user data

      // Clear text fields and stop loading after a successful login
      usernameController.clear();
      passwordController.clear();

      if (userStatus == 'approved') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBarScreen(user: loginResponse.user),
          ),
        );
        // Show success toast
        ToastService.showToast(
          context: context,
          title: 'Login Success',
          message: 'Welcome, ${loginResponse.user.name}!',
          type: ToastificationType.success,
        );
      } else if (userStatus == 'pending') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AccountVerification()),
        );
      } else {
        ToastService.showToast(
          context: context,
          title: 'Sorry',
          message: "Unknown status.",
          type: ToastificationType.error,
        );
      }
    } else {
      ToastService.showToast(
        context: context,
        title: 'Error',
        message: 'Failed to connect to the server.',
        type: ToastificationType.error,
      );
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("An error occurred. Please try again.")),
    );
  } finally {
    setLoadingState(false); // Always stop loading after handling the response
  }
}

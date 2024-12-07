import 'dart:convert';

import 'package:bpexch/Service/toast_service.dart';
import 'package:bpexch/model/user_model.dart';
import 'package:bpexch/utils/api_config.dart';
import 'package:bpexch/widgets/custom_elevated_button.dart';
import 'package:bpexch/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

import '../../utils/Reusable/blurred_background.dart';

class ChangePassword extends StatefulWidget {
  final UserModel user;

  const ChangePassword({super.key, required this.user});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.resetPassword}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'password': passwordController.text,
        'id': widget.user.id,
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      Navigator.pop(context);
      print('************Response: ${response.body} ************');
      ToastService.showToast(
        context: context,
        title: 'Password Upated',
        message: 'Congrats you password has been changed. ${widget.user.name}!',
        type: ToastificationType.success,
      );
    } else {
      print('Failed to reset password: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(fontSize: 18.sp),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const BlurredBackground(
            imagePath: 'assets/images/appimage.jpg',
            blurSigmaX: 15,
            blurSigmaY: 15,
            opacity: 0.2,
          ),
          Positioned(
            top: 70.h,
            left: 10.w,
            right: 10.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Change Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Your new password should be strong to ensure the security of your account. A strong password includes a mix of uppercase and lowercase letters, numbers, and special characters. Avoid using easily guessable information like your name or birthdate.",
                  style: TextStyle(color: Colors.white, fontSize: 13.sp),
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  width: double.infinity,
                  child: CustomTextField(
                    hintText: 'Password',
                    iconPath: 'assets/icons/lock.svg',
                    isPasswordField: true,
                    controller: passwordController,
                  ),
                ),
                SizedBox(height: 50.h),
                isLoading
                    ? Center(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 60.r,
                        ),
                      )
                    : CustomElevatedButton(
                        text: 'Reset Password',
                        onPressed: resetPassword,
                        height: 60.h,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.green,
                        borderRadius: 20.r,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

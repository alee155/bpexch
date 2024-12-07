import 'dart:ui';

import 'package:bpexch/Service/login_service.dart';
import 'package:bpexch/Service/toast_service.dart';
import 'package:bpexch/auth/account_verification.dart';
import 'package:bpexch/auth/signupscreen.dart';
import 'package:bpexch/provider/animation_provider.dart';
import 'package:bpexch/view/BottomNavBar/bottomnavbar.dart';
import 'package:bpexch/widgets/custom_elevated_button.dart';
import 'package:bpexch/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final LoginService _loginService = LoginService(); // Initialize service

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final loginResponse = await _loginService.loginUser(username, password);

      if (loginResponse != null) {
        // Convert the status to lowercase for case-insensitive comparison
        String userStatus = loginResponse.user.status.toLowerCase();

        // Check if the user status is "approved" (case insensitive)
        if (userStatus == 'approved') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BottomNavBarScreen(user: loginResponse.user),
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
            MaterialPageRoute(
                builder: (context) => const AccountVerification()),
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
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AnimationProvider()..initializeAnimation(this),
      child: Scaffold(
        body: Consumer<AnimationProvider>(
          builder: (context, animationProvider, child) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/appimage.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 10.h,
                  left: 10.w,
                  right: 10.w,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 100.h,
                        ),
                        Column(
                          children: [
                            AnimatedBuilder(
                              animation: animationProvider.controller,
                              builder: (context, child) {
                                return Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        animationProvider
                                                .colorAnimation1Value.value ??
                                            Colors.white,
                                        animationProvider
                                                .colorAnimation2Value.value ??
                                            Colors.white,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 80.r,
                                    backgroundImage: const AssetImage(
                                        'assets/images/bplogo.png'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Welcome To Login Page!',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: CustomTextField(
                                      hintText: 'Username',
                                      iconPath: 'assets/icons/user.svg',
                                      controller: usernameController,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  SizedBox(
                                    width: double.infinity,
                                    child: CustomTextField(
                                      hintText: 'Password',
                                      iconPath: 'assets/icons/lock.svg',
                                      isPasswordField: true,
                                      controller: passwordController,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30.h),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Sign up",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            GestureDetector(
                              onTap: () async {
                                const url = 'https://www.youtube.com/';
                                if (await canLaunchUrlString(url)) {
                                  await launchUrlString(url,
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Could not launch $url')),
                                  );
                                }
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: "Facing a problem? ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Click here.",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        Visibility(
                          visible: !isLoading,
                          child: CustomElevatedButton(
                            text: 'Login',
                            onPressed: () => handleLogin(),
                            height: 60.h,
                            width: 250.w,
                            color: Colors.green,
                            borderRadius: 20.r,
                          ),
                        ),
                        Visibility(
                          visible: isLoading,
                          child: SpinKitFadingCircle(
                            color: Colors.green,
                            size: 60.r,
                          ),
                        ),
                        SizedBox(height: 30.r),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

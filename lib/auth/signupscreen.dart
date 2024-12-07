import 'dart:convert';
import 'dart:ui';

import 'package:bpexch/Service/toast_service.dart';
import 'package:bpexch/auth/loginscreen.dart';
import 'package:bpexch/utils/apis_services/validators.dart';
import 'package:bpexch/widgets/custom_elevated_button.dart';
import 'package:bpexch/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http; // Add this import
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  bool isChecked = false;
  bool isLoading = false; // Add a loading flag

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 1.5, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );
  }

  Future<void> openWhatsApp(BuildContext context, String phoneNumber) async {
    final whatsappUrl = "https://wa.me/$phoneNumber";

    if (await canLaunchUrlString(whatsappUrl)) {
      await launchUrlString(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open WhatsApp")),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    nameController.dispose();
    usernameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool isFormValid = false;
  void _validateForm() {
    final name = nameController.text.trim();
    final username = usernameController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    final isValid = name.isNotEmpty &&
        username.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword &&
        isChecked;

    setState(() {
      isFormValid = isValid;
    });
  }

  Future<void> handleSignUp() async {
    final name = nameController.text.trim();
    final username = usernameController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    final nameError = Validators.validateName(name);
    final usernameError = Validators.validateUsername(username);
    final phoneNumberError = Validators.validatePhoneNumber(phoneNumber);
    final passwordError = Validators.validatePassword(password);
    final confirmPasswordError =
        Validators.validateConfirmPassword(password, confirmPassword);

    if (nameError != null ||
        usernameError != null ||
        phoneNumberError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      print(nameError ?? '');
      print(usernameError ?? '');
      print(phoneNumberError ?? '');
      print(passwordError ?? '');
      print(confirmPasswordError ?? '');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fix the errors before signing up.")),
      );
      return;
    }

    // Create a dummy email from the username or use a default email
    final email =
        "$username@bpexch.com"; // You can generate this or use a fixed one like example@example.com

    setState(() {
      isLoading = true;
    });

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
            MaterialPageRoute(builder: (context) => const LoginScreen()),
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
          ToastificationType toastType = ToastificationType.success;

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
        ToastificationType toastType = ToastificationType.success;

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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            top: 30.h,
            left: 10.w,
            right: 10.w,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          ),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: CircleAvatar(
                          radius: 50.r,
                          backgroundImage:
                              const AssetImage('assets/images/bplogo.png'),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Welcome To Signup!',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: 'Name',
                              iconPath: 'assets/icons/user.svg',
                              controller: nameController,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              hintText: 'Username',
                              iconPath: 'assets/icons/user.svg',
                              controller: usernameController,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              hintText: 'Phone Number',
                              iconPath: 'assets/icons/phone.svg',
                              controller: phoneNumberController,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              hintText: 'Password',
                              iconPath: 'assets/icons/lock.svg',
                              isPasswordField: true,
                              controller: passwordController,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              hintText: 'Confirm Password',
                              iconPath: 'assets/icons/lock.svg',
                              isPasswordField: true,
                              controller: confirmPasswordController,
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                      _validateForm();
                                    });
                                  },
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                ),
                                SizedBox(width: 8.w),
                                GestureDetector(
                                  onTap: () async {
                                    const url = 'https://www.youtube.com/';
                                    if (await canLaunchUrlString(url)) {
                                      await launchUrlString(url,
                                          mode: LaunchMode.externalApplication);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Could not launch $url')),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'User Agreement',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _bounceAnimation.value,
                                      child: child,
                                    );
                                  },
                                  child: GestureDetector(
                                    onTap: () => openWhatsApp(
                                        context, "+92 300 8497241"),
                                    child: Container(
                                      width: 50.w,
                                      height: 50.h,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/whatsapp.png',
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Visibility(
                              visible: !isLoading,
                              child: CustomElevatedButton(
                                text: 'Sign up',
                                onPressed: isFormValid ? handleSignUp : null,
                                height: 60.h,
                                width: 250.w,
                                color: isFormValid ? Colors.green : Colors.grey,
                                borderRadius: 20.r,
                              ),
                            ),
                            Visibility(
                              visible: isLoading,
                              child: SpinKitFadingCircle(
                                color: Colors.white,
                                size: 60.r,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

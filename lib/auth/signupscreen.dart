import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bpexch/Service/getStoredWhatsappNo.dart';
import 'package:bpexch/Service/launchWhatsApp.dart';
import 'package:bpexch/Service/signup_service.dart';
import 'package:bpexch/utils/text_styles.dart';
import 'package:bpexch/widgets/custom_elevated_button.dart';
import 'package:bpexch/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignupScreen extends StatefulWidget {
  final String? companyInfo;
  const SignupScreen({super.key, this.companyInfo});

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
  final TimeService _timeService = TimeService(); // Initialize TimeService
  String? storedWhatsappNo;
  @override
  void initState() {
    super.initState();
    _loadLogo();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 1.5, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );

    _timeService.fetchTime().then((_) async {
      String? whatsappNo = await _timeService.getStoredWhatsappNo();
      setState(() {
        storedWhatsappNo = whatsappNo;
      });
    });

    // Add listeners to text controllers
    nameController.addListener(_validateForm);
    usernameController.addListener(_validateForm);
    phoneNumberController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    confirmPasswordController.addListener(_validateForm);
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

  void _launchWhatsApp() async {
    await launchWhatsApp(
        storedWhatsappNo); // Call the function from whatsapp_service.dart
  }

  Uint8List? imageBytes;
  Future<void> _loadLogo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Logo = prefs.getString('company_logo');

    if (base64Logo != null) {
      setState(() {
        imageBytes = base64Decode(base64Logo);
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
                        child: imageBytes == null
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: CircleAvatar(
                                  radius: 50.r,
                                  backgroundColor: Colors.grey[
                                      300], // Placeholder background color
                                ),
                              )
                            : CircleAvatar(
                                radius: 50.r,
                                backgroundImage:
                                    Image.memory(imageBytes!).image,
                                backgroundColor: Colors.transparent,
                              ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Welcome To ${widget.companyInfo}',
                        style: AppTextStyles.appnametext(18),
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
                                      _validateForm(); // Revalidate the form when checkbox changes
                                    });
                                  },
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                ),
                                SizedBox(width: 8.w),
                                GestureDetector(
                                  onTap: () async {
                                    const url =
                                        'https://bpexchdeals.com/privacy/policy';
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
                                    onTap: _launchWhatsApp,
                                    child: Container(
                                      width: 50.w,
                                      height: 50.h,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/whatsapp.png'),
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
                                onPressed: isFormValid
                                    ? () {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        SignupService()
                                            .handleSignUp(
                                          context,
                                          nameController.text.trim(),
                                          usernameController.text.trim(),
                                          phoneNumberController.text.trim(),
                                          passwordController.text,
                                          confirmPasswordController.text,
                                        )
                                            .whenComplete(() {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        });
                                      }
                                    : null,
                                height: 60.h,
                                width: 250.w,
                                color: isFormValid ? Colors.green : Colors.grey,
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

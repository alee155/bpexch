import 'dart:convert';
import 'dart:ui';

import 'package:bpexch/Service/getStoredWhatsappNo.dart';
import 'package:bpexch/Service/handleLogin.dart';
import 'package:bpexch/Service/launchWhatsApp.dart';
import 'package:bpexch/Service/login_service.dart';
import 'package:bpexch/auth/signupscreen.dart';
import 'package:bpexch/provider/animation_provider.dart';
import 'package:bpexch/utils/text_styles.dart';
import 'package:bpexch/widgets/custom_elevated_button.dart';
import 'package:bpexch/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  String? companyInfo;
  LoginScreen({super.key, this.companyInfo});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final LoginService _loginService = LoginService();
  final TimeService _timeService = TimeService();
  String? storedWhatsappNo;

  Uint8List? imageBytes;

  @override
  void dispose() {
    usernameController.clear();
    passwordController.clear();
    isLoading = false;
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _timeService.fetchTime().then((_) async {
      String? whatsappNo = await _timeService.getStoredWhatsappNo();
      setState(() {
        storedWhatsappNo = whatsappNo;
      });
    });
    _fetchCompanyInfo();
    _loadLogo();
  }

  Future<void> _fetchCompanyInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedCompanyInfo = prefs.getString('companyInfo');
    print('***Fetched Company Info: $storedCompanyInfo');
    setState(() {
      widget.companyInfo = storedCompanyInfo;
    });
  }

  // Load the logo from SharedPreferences
  Future<void> _loadLogo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Logo = prefs.getString('company_logo');

    if (base64Logo != null) {
      setState(() {
        imageBytes = base64Decode(base64Logo);
      });
    }
  }

  void _launchWhatsApp() async {
    await launchWhatsApp(storedWhatsappNo);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AnimationProvider()..initializeAnimation(this),
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
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
                          SizedBox(height: 100.h),
                          Column(
                            children: [
                              AnimatedBuilder(
                                animation: animationProvider.controller,
                                builder: (context, child) {
                                  return Container(
                                    padding: EdgeInsets.all(6.r),
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
                                    child: imageBytes == null
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: CircleAvatar(
                                              radius: 80.r,
                                              backgroundColor: Colors.grey[
                                                  300], // Placeholder background color
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 80.r,
                                            backgroundImage:
                                                Image.memory(imageBytes!).image,
                                            backgroundColor: Colors.transparent,
                                          ),
                                  );
                                },
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                'Welcome To ${widget.companyInfo}',
                                style: AppTextStyles.appnametext(18),
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
                                      builder: (context) => SignupScreen(
                                          companyInfo: widget.companyInfo),
                                    ),
                                  );
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: "Don't have an account? ",
                                    style: AppTextStyles.whiteText(16),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Sign up",
                                        style: AppTextStyles.greenText(16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              GestureDetector(
                                onTap:
                                    _launchWhatsApp, // Launch WhatsApp when tapped
                                child: RichText(
                                  text: TextSpan(
                                    text: "Facing a problem? ",
                                    style: AppTextStyles.whiteText(16),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Click here.",
                                        style: AppTextStyles.greenText(16),
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
                              onPressed: () {
                                setState(() {
                                  isLoading = true;
                                });
                                handleLogin(
                                  context,
                                  usernameController.text.trim(),
                                  passwordController.text.trim(),
                                  _loginService,
                                  usernameController,
                                  passwordController,
                                  (bool loading) {
                                    setState(() {
                                      isLoading = loading;
                                    });
                                  },
                                );
                              },
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
      ),
    );
  }
}

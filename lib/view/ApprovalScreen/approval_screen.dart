import 'package:bpexch/auth/loginscreen.dart';
import 'package:bpexch/utils/Reusable/blurred_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({super.key});

  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BlurredBackground(
            imagePath: 'assets/images/appimage.jpg',
            blurSigmaX: 15,
            blurSigmaY: 15,
            opacity: 0.2,
          ),
          Positioned(
            top: 150.h,
            left: 10.w,
            right: 10.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Approval Status',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Your account creation request has been submitted successfully. Our admin team is currently reviewing your application to ensure all details are correct and meet our guidelines.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  'This process may take a few hours. Please be patient as we strive to maintain a secure and efficient platform for all users.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  'Once your account is approved, you will receive a notification. Until then, feel free to contact support if you have any questions or concerns.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50.h),
                SpinKitCubeGrid(
                  color: Colors.white,
                  size: 60.r,
                ),
                SizedBox(width: 10.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

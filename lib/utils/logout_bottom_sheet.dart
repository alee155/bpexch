import 'package:bpexch/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutBottomSheet extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onCancel;

  const LogoutBottomSheet({
    super.key,
    required this.onLogout,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/signout.png',
            height: 100.h,
            width: 100.w,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10.h),
          Text(
            'Are you sure you want to log out?',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: onCancel,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text(
                    'No',
                    style: WallatTextStyle.subtitleStyle,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              SizedBox(
                width: 150.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: onLogout,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    'Yes',
                    style: WallatTextStyle.subtitleStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CloseAppSheet extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onCancel;

  const CloseAppSheet({
    super.key,
    required this.onLogout,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/signout.png',
            height: 100.h,
            width: 100.w,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10.h),
          Text(
            'Are you sure you want to leave?',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: onCancel,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text(
                    'No',
                    style: WallatTextStyle.subtitleStyle,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              SizedBox(
                width: 150.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: onLogout,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    'Yes',
                    style: WallatTextStyle.subtitleStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

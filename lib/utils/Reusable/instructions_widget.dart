import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnglishInstructions extends StatelessWidget {
  const EnglishInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "1. Send payment on about account.",
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
          Text(
            "2. Upload payment proof and submit.",
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
          Text(
            "3. Payment will be approved in 30 minutes.",
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
          Text(
            "4. Please kindly upload the transaction screenshot.",
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}

class UrduInstructions extends StatelessWidget {
  const UrduInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "اس اکاؤنٹ پر رقم منتقل کریں۔",
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            Text(
              "ادائیگی کا ثبوت اپ لوڈ کریں اور سبمٹ کریں۔",
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            Text(
              "ادائیگی 30 منٹ میں منظور ہو جائے گی۔",
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            Text(
              'مہربانی کر کے ٹرانزیکشن والا اسکرین شاٹ اپلوڈ کریں۔',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}

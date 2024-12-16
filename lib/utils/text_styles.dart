import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle whiteText(double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontSize: fontSize.sp,
    );
  }

  static TextStyle appnametext(double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontSize: fontSize.sp,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
    );
  }
  static TextStyle signuptext(double fontSize) {
    return TextStyle(
       
        color: Colors.green,
        fontWeight: FontWeight.bold,
        fontSize: fontSize.sp);
  }

  static TextStyle greenText(double fontSize) {
    return TextStyle(color: Colors.green, fontSize: fontSize.sp);
  }

  static TextStyle redText(double fontSize) {
    return TextStyle(color: Colors.red, fontSize: fontSize.sp);
  }

  static TextStyle blueText(double fontSize) {
    return TextStyle(color: Colors.blue, fontSize: fontSize.sp);
  }
}

class WallatTextStyle {
  static TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subtitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 15.sp,
  );

  static TextStyle buttonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle dialogContentStyle = TextStyle(
    color: Colors.white,
    fontSize: 15.sp,
  );

  static TextStyle labelStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.sp,
  );
}

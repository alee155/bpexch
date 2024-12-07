import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerEffect() {
  return ListView.builder(
    itemCount: 5, // You can set a fixed count for the shimmer items
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Shimmer.fromColors(
          baseColor: const Color.fromARGB(56, 255, 255, 255).withOpacity(0.1),
          highlightColor: const Color.fromARGB(52, 245, 245, 245),
          child: Container(
            height: 100.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      );
    },
  );
}

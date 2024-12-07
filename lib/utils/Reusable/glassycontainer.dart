import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlassContainer extends StatelessWidget {
  final List<Map<String, String>> info;

  const GlassContainer({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          height: 200.h,
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: info.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> item = entry.value;
              return Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['label']!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        item['value']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                  if (index < info.length - 1)
                    Divider(
                      color: Colors.white54,
                      thickness: 0.5,
                      height: 20.h,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImagePickerBottomSheet {
  static void show({
    required BuildContext context,
    required VoidCallback onGalleryTap,
    required VoidCallback onCameraTap,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/gallery.svg',
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                title: const Text(
                  "Choose from Gallery",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onGalleryTap();
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/camera.svg',
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                title: const Text(
                  "Take a Photo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onCameraTap();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ConfirmationBottomSheet {
  static void show({
    required BuildContext context,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Are you sure to transfer this amount?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/yes.svg',
                      height: 24,
                      width: 24,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Yes.",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  onCancel();
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/nope.svg',
                      height: 24,
                      width: 24,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "No",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

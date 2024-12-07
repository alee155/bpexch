import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Allow nullable VoidCallback
  final double height;
  final double width;
  final Color color;
  final double borderRadius;

  const CustomElevatedButton({
    required this.text,
    required this.onPressed, // Marked as nullable
    required this.height,
    required this.width,
    required this.color,
    required this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // This works now
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: Size(width, height),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 20.sp),
      ),
    );
  }
}

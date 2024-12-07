import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredBackground extends StatelessWidget {
  final String imagePath;
  final double blurSigmaX;
  final double blurSigmaY;
  final double opacity;

  const BlurredBackground({
    super.key,
    required this.imagePath,
    this.blurSigmaX = 15,
    this.blurSigmaY = 15,
    this.opacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
            child: Container(
              color: Colors.black.withOpacity(opacity),
            ),
          ),
        ),
      ],
    );
  }
}

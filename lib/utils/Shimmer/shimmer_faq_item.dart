import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFaqItem extends StatelessWidget {
  const ShimmerFaqItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(56, 255, 255, 255).withOpacity(0.1),
        highlightColor: const Color.fromARGB(52, 245, 245, 245),
        child: Container(
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

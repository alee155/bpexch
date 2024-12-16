import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late Future<List<Uint8List>> _images;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _images = fetchMultipleImages();
  }

  Future<List<Uint8List>> fetchMultipleImages() async {
    final url = Uri.parse('https://bpexchdeals.com/api/getAlert');
    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        final List<Uint8List> images = [];
        images.add(response.bodyBytes); // Simulated single image
        return images;
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 197, 195, 195),
      highlightColor: const Color.fromARGB(52, 245, 245, 245),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1, // Simulate 3 placeholders
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Container(
              width: 350.w,
              height: 250.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: FutureBuilder<List<Uint8List>>(
        future: _images,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmer();
          } else if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const SizedBox.shrink();
          }

          final images = snapshot.data!;
          return Stack(
            children: [
              PageView.builder(
                itemCount: images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.memory(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 10.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: _currentPage == index ? 12.w : 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

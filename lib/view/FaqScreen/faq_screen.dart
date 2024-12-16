import 'package:bpexch/Service/faq_service.dart';
import 'package:bpexch/utils/Reusable/blurred_background.dart';
import 'package:bpexch/utils/Shimmer/shimmer_faq_item.dart';
import 'package:bpexch/utils/text_styles.dart';
import 'package:bpexch/view/FaqScreen/custom_accordion_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/faq_model.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  bool isFetchingData = true;
  List<Faq> faqs = [];

  @override
  void initState() {
    super.initState();
    fetchFaqsFromService();
  }

  // Fetch FAQs using the service
  Future<void> fetchFaqsFromService() async {
    try {
      final fetchedFaqs = await FaqService.fetchFaqs();
      setState(() {
        faqs = fetchedFaqs;
      });
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      setState(() {
        isFetchingData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Faqs',
          style: AppTextStyles.whiteText(20),
        ),
      ),
      body: Stack(
        children: [
          const BlurredBackground(
            imagePath: 'assets/images/appimage.jpg',
            blurSigmaX: 15,
            blurSigmaY: 15,
            opacity: 0.2,
          ),
          Positioned.fill(
            child: isFetchingData
                ? SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        13,
                        (index) => const ShimmerFaqItem(),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemCount: faqs.length,
                    itemBuilder: (context, index) {
                      final faq = faqs[index];
                      return FaqItem(faq: faq);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

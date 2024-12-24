import 'package:bpexch/model/faq_model.dart';
import 'package:bpexch/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqItem extends StatelessWidget {
  final Faq faq;

  const FaqItem({super.key, required this.faq});

  // Function to launch the URL
  Future<void> _launchURL(String url) async {
    debugPrint('Launching URL: $url');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Helper function to check if the string should be treated as a link
  bool _isLink(String text) {
    return text.toLowerCase().contains("http") ||
        text.toLowerCase().contains("link");
  }

  @override
  Widget build(BuildContext context) {
    // Log the content once during the widget's build
    debugPrint('--- FAQ Content ---\n${faq.content}\n-------------------');

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          radius: 18.r,
          backgroundColor: Colors.green.withOpacity(0.2),
          child: const Icon(
            Icons.info_outline,
            color: Colors.green,
            size: 20,
          ),
        ),
        collapsedBackgroundColor: Colors.grey[900],
        backgroundColor: Colors.grey[850],
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        tilePadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                faq.subject,
                style: AppTextStyles.whiteText(16).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isLink(faq.content)) ...[
                  // Show a button to view the link
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchURL(faq.content),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade800,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 20.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      icon: Icon(
                        Icons.link,
                        size: 18.r,
                        color: Colors.white,
                      ),
                      label: Text(
                        'View Link',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                ] else ...[
                  // Render HTML content if it exists
                  Html(
                    data: faq.content,
                    style: {
                      "body": Style(
                        color: Colors.white,
                        fontSize: FontSize(14.sp),
                      ),
                    },
                  ),
                  SizedBox(height: 8.h),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

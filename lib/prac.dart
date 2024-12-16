// // import 'package:bpexch/Service/getStoredWhatsappNo.dart';
// // import 'package:bpexch/Service/launchWhatsApp.dart';
// // import 'package:bpexch/auth/loginscreen.dart';
// // import 'package:bpexch/model/user_model.dart';
// // import 'package:bpexch/provider/pagestate_provider.dart';
// // import 'package:bpexch/utils/Reusable/blurred_background.dart';
// // import 'package:bpexch/utils/Reusable/glassycontainer.dart';
// // import 'package:bpexch/utils/logout_bottom_sheet.dart';
// // import 'package:bpexch/utils/saveToken.dart';
// // import 'package:bpexch/view/Drawer/drawer.dart';
// // import 'package:bpexch/view/HistoryScreen/history_screen.dart';
// // import 'package:bpexch/widgets/custom_elevated_button.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:provider/provider.dart';

// // class AccountScreen extends StatefulWidget {
// //   final UserModel user;

// //   const AccountScreen({super.key, required this.user});
// //   @override
// //   _AccountScreenState createState() => _AccountScreenState();
// // }

// // class _AccountScreenState extends State<AccountScreen>
// //     with TickerProviderStateMixin {
// //   late AnimationController _controller;
// //   late Animation<double> _bounceAnimation;
// //   final TimeService _timeService = TimeService(); // Initialize TimeService
// //   String? storedWhatsappNo;
// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = AnimationController(
// //       duration: const Duration(seconds: 1),
// //       vsync: this,
// //     )..repeat(reverse: true);
// //     print("id: ${widget.user.id}");
// //     _bounceAnimation = Tween<double>(begin: 1.5, end: 1.2).animate(
// //       CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
// //     );
// //     _timeService.fetchTime().then((_) async {
// //       // Get stored WhatsApp number after fetching time
// //       String? whatsappNo = await _timeService.getStoredWhatsappNo();
// //       setState(() {
// //         storedWhatsappNo = whatsappNo;
// //       });
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   void _launchWhatsApp() async {
// //     await launchWhatsApp(
// //         storedWhatsappNo); // Call the function from whatsapp_service.dart
// //   }

// //   Future<bool> _onWillPop() async {
// //     showModalBottomSheet(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return LogoutBottomSheet(
// //           onCancel: () {
// //             Navigator.of(context).pop(false);
// //           },
// //           onLogout: () async {
// //             // Clear the saved token and user data
// //             await clearUserData();
// //             // Navigate the user to the login screen
// //             Navigator.pushReplacement(
// //               context,
// //               MaterialPageRoute(builder: (context) => const LoginScreen()),
// //             );
// //           },
// //         );
// //       },
// //     );
// //     return false; // Prevent the back navigation
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final List<String> images = [
// //       'assets/images/image1.jpeg',
// //       'assets/images/image2.jpeg',
// //       'assets/images/image3.jpg',
// //     ];

// //     return ChangeNotifierProvider(
// //       create: (_) => PageStateProvider(),
// //       child: WillPopScope(
// //         onWillPop: _onWillPop,
// //         child: Scaffold(
// //           appBar: AppBar(
// //             backgroundColor: const Color.fromARGB(255, 9, 40, 65),
// //             elevation: 0,
// //             centerTitle: true,
// //             iconTheme: const IconThemeData(color: Colors.white),
// //             title: Text(
// //               'bpexch',
// //               style: TextStyle(
// //                   color: Colors.white,
// //                   fontSize: 20.sp,
// //                   fontWeight: FontWeight.bold),
// //             ),
// //           ),
// //           drawer: CustomDrawer(user: widget.user),
// //           body: Stack(
// //             children: [
// //               const BlurredBackground(
// //                 imagePath: 'assets/images/appimage.jpg',
// //                 blurSigmaX: 15,
// //                 blurSigmaY: 15,
// //                 opacity: 0.2,
// //               ),
// //               Positioned(
// //                 top: 50.h,
// //                 left: 10.w,
// //                 right: 10.w,
// //                 child: Column(
// //                   children: [
// //                     GlassContainer(
// //                       info: [
// //                         {
// //                           "label": "Name",
// //                           "value": widget.user.name ?? 'N/A',
// //                         },
// //                         {
// //                           "label": "bpexch id",
// //                           "value": widget.user.bpUsername ?? 'N/A',
// //                         },
// //                         {
// //                           "label": "bpexch Password",
// //                           "value": widget.user.bpPassword ?? 'N/A',
// //                         },
// //                       ],
// //                     ),
// //                     SizedBox(height: 20.h),
// //                     // Container(
// //                     //   height: 200.h,
// //                     //   decoration: BoxDecoration(
// //                     //     color: Colors.white,
// //                     //     borderRadius: BorderRadius.all(
// //                     //       Radius.circular(10.r),
// //                     //     ),
// //                     //   ),
// //                     //   child: Column(
// //                     //     children: [
// //                     //       Expanded(
// //                     //         child: Consumer<PageStateProvider>(
// //                     //           builder: (context, provider, _) {
// //                     //             return PageView.builder(
// //                     //               itemCount: images.length,
// //                     //               controller: PageController(),
// //                     //               onPageChanged: (int page) {
// //                     //                 provider.setPage(page);
// //                     //               },
// //                     //               itemBuilder: (context, index) {
// //                     //                 return ClipRRect(
// //                     //                   borderRadius: BorderRadius.all(
// //                     //                     Radius.circular(10.r),
// //                     //                   ),
// //                     //                   child: Image.asset(
// //                     //                     images[index],
// //                     //                     fit: BoxFit.cover,
// //                     //                   ),
// //                     //                 );
// //                     //               },
// //                     //             );
// //                     //           },
// //                     //         ),
// //                     //       ),
// //                     //     ],
// //                     //   ),
// //                     // ),
// //                     SizedBox(height: 10.h),
// //                     // Consumer<PageStateProvider>(
// //                     //   builder: (context, provider, _) {
// //                     //     return Row(
// //                     //       mainAxisAlignment: MainAxisAlignment.center,
// //                     //       children: List.generate(
// //                     //         images.length,
// //                     //         (index) => AnimatedContainer(
// //                     //           duration: const Duration(milliseconds: 300),
// //                     //           margin: EdgeInsets.symmetric(horizontal: 5.w),
// //                     //           height:
// //                     //               provider.currentPage == index ? 12.h : 8.h,
// //                     //           width: provider.currentPage == index ? 30.w : 8.w,
// //                     //           decoration: BoxDecoration(
// //                     //             color: provider.currentPage == index
// //                     //                 ? Colors.white
// //                     //                 : Colors.grey,
// //                     //             borderRadius: BorderRadius.all(
// //                     //               Radius.circular(provider.currentPage == index
// //                     //                   ? 8.r
// //                     //                   : 50.r),
// //                     //             ),
// //                     //           ),
// //                     //         ),
// //                     //       ),
// //                     //     );
// //                     //   },
// //                     // ),
// //                     SizedBox(height: 30.h),
// //                     CustomElevatedButton(
// //                       text: 'View History',
// //                       onPressed: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) =>
// //                                 HistoryScreen(user: widget.user),
// //                           ),
// //                         );
// //                       },
// //                       height: 60.h,
// //                       width: MediaQuery.of(context).size.width,
// //                       color: const Color.fromARGB(255, 9, 40, 65),
// //                       borderRadius: 20.r,
// //                     ),
// //                     SizedBox(height: 20.h),
// //                     Align(
// //                       alignment: Alignment.topRight,
// //                       child: AnimatedBuilder(
// //                         animation: _controller,
// //                         builder: (context, child) {
// //                           return Transform.scale(
// //                             scale: _bounceAnimation.value,
// //                             child: child,
// //                           );
// //                         },
// //                         child: GestureDetector(
// //                           onTap: _launchWhatsApp,
// //                           child: Container(
// //                             width: 50.w,
// //                             height: 50.h,
// //                             decoration: const BoxDecoration(
// //                               shape: BoxShape.circle,
// //                               image: DecorationImage(
// //                                 image: AssetImage(
// //                                   'assets/images/whatsapp.png',
// //                                 ),
// //                                 fit: BoxFit.contain,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart' as http;
// import 'package:shimmer/shimmer.dart';

// class ImageCarousel extends StatefulWidget {
//   const ImageCarousel({super.key});

//   @override
//   _ImageCarouselState createState() => _ImageCarouselState();
// }

// class _ImageCarouselState extends State<ImageCarousel> {
//   late Future<List<Uint8List>> _images;
//   int _currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _images = fetchMultipleImages();
//   }

//   Future<List<Uint8List>> fetchMultipleImages() async {
//     final url = Uri.parse('https://bpexchdeals.com/api/getAlert');
//     try {
//       final response = await http.post(url);
//       if (response.statusCode == 200) {
//         final List<Uint8List> images = [];
//         images.add(response.bodyBytes); // Simulated single image
//         return images;
//       } else {
//         print('Error: ${response.statusCode}');
//         return [];
//       }
//     } catch (e) {
//       print('Exception: $e');
//       return [];
//     }
//   }

//   Widget _buildShimmer() {
//     return Shimmer.fromColors(
//       baseColor: const Color.fromARGB(56, 255, 255, 255).withOpacity(0.1),
//       highlightColor: const Color.fromARGB(52, 245, 245, 245),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 3, // Simulate 3 placeholders
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.w),
//             child: Container(
//               width: 250.w,
//               height: 250.h,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10.r),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 250.h,
//       child: FutureBuilder<List<Uint8List>>(
//         future: _images,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return _buildShimmer();
//           } else if (snapshot.hasError ||
//               snapshot.data == null ||
//               snapshot.data!.isEmpty) {
//             return Center(
//               child: Text(
//                 'No images available',
//                 style: TextStyle(color: Colors.red, fontSize: 16.sp),
//               ),
//             );
//           }

//           final images = snapshot.data!;
//           return Stack(
//             children: [
//               PageView.builder(
//                 itemCount: images.length,
//                 onPageChanged: (index) {
//                   setState(() {
//                     _currentPage = index;
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   return ClipRRect(
//                     borderRadius: BorderRadius.circular(10.r),
//                     child: Image.memory(
//                       images[index],
//                       fit: BoxFit.cover,
//                     ),
//                   );
//                 },
//               ),
//               Positioned(
//                 bottom: 10.h,
//                 left: 0,
//                 right: 0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(images.length, (index) {
//                     return AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       margin: EdgeInsets.symmetric(horizontal: 4.w),
//                       width: _currentPage == index ? 12.w : 8.w,
//                       height: 8.h,
//                       decoration: BoxDecoration(
//                         color:
//                             _currentPage == index ? Colors.blue : Colors.grey,
//                         borderRadius: BorderRadius.circular(4.r),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:bpexch/model/faq_model.dart';
import 'package:bpexch/utils/text_styles.dart';
import 'package:flutter/material.dart';
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
    return text.toLowerCase().contains("link");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          radius: 20.r,
          backgroundColor: Colors.green.withOpacity(0.2),
          child: Icon(
            Icons.info_outline,
            color: Colors.green,
            size: 20.sp,
          ),
        ),
        collapsedBackgroundColor: Colors.grey[900],
        backgroundColor: Colors.black,
        iconColor: Colors.green,
        collapsedIconColor: Colors.white,
        tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                faq.subject,
                style: AppTextStyles.whiteText(16).copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                faq.status,
                style: AppTextStyles.whiteText(12),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isLink(faq.type))
                  ElevatedButton(
                    onPressed: () => _launchURL(faq.content),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.link,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Open Link',
                          style: AppTextStyles.whiteText(14).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                else ...[
                  Text(
                    'Type:',
                    style: AppTextStyles.whiteText(14).copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    faq.type,
                    style: AppTextStyles.whiteText(14),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Content:',
                    style: AppTextStyles.whiteText(14).copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    faq.content,
                    style: AppTextStyles.whiteText(14),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

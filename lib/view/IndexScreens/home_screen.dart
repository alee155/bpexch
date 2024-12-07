import 'package:bpexch/model/user_model.dart';
import 'package:bpexch/provider/pagestate_provider.dart';
import 'package:bpexch/utils/Reusable/blurred_background.dart';
import 'package:bpexch/utils/Reusable/glassycontainer.dart';
import 'package:bpexch/utils/logout_bottom_sheet.dart';
import 'package:bpexch/view/Drawer/drawer.dart';
import 'package:bpexch/view/HistoryScreen/history_screen.dart';
import 'package:bpexch/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AccountScreen extends StatefulWidget {
  final UserModel user;

  const AccountScreen({super.key, required this.user});
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    print("id: ${widget.user.id}");
    _bounceAnimation = Tween<double>(begin: 1.5, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> openWhatsApp(BuildContext context, String phoneNumber) async {
    final whatsappUrl = "https://wa.me/$phoneNumber";

    if (await canLaunchUrlString(whatsappUrl)) {
      await launchUrlString(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open WhatsApp")),
      );
    }
  }

  Future<bool> _onWillPop() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LogoutBottomSheet(
          onCancel: () {
            Navigator.of(context).pop(false);
          },
          onLogout: () {
            Navigator.of(context).pop(true);
          },
        );
      },
    );
    return false; // Prevent the back navigation
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/images/image1.jpeg',
      'assets/images/image2.jpeg',
      'assets/images/image3.jpg',
    ];

    return ChangeNotifierProvider(
      create: (_) => PageStateProvider(),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 9, 40, 65),
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              'bpexch',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          drawer: CustomDrawer(user: widget.user),
          body: Stack(
            children: [
              const BlurredBackground(
                imagePath: 'assets/images/appimage.jpg',
                blurSigmaX: 15,
                blurSigmaY: 15,
                opacity: 0.2,
              ),
              Positioned(
                top: 50.h,
                left: 10.w,
                right: 10.w,
                child: Column(
                  children: [
                    GlassContainer(
                      info: [
                        {
                          "label": "Name",
                          "value": widget.user.name ?? 'N/A',
                        },
                        {
                          "label": "bpexch id",
                          "value": widget.user.bpUsername ?? 'N/A',
                        },
                        {
                          "label": "bpexch Password",
                          "value": widget.user.bpPassword ?? 'N/A',
                        },
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Consumer<PageStateProvider>(
                              builder: (context, provider, _) {
                                return PageView.builder(
                                  itemCount: images.length,
                                  controller: PageController(),
                                  onPageChanged: (int page) {
                                    provider.setPage(page);
                                  },
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.r),
                                      ),
                                      child: Image.asset(
                                        images[index],
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Consumer<PageStateProvider>(
                      builder: (context, provider, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            images.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              height:
                                  provider.currentPage == index ? 12.h : 8.h,
                              width: provider.currentPage == index ? 30.w : 8.w,
                              decoration: BoxDecoration(
                                color: provider.currentPage == index
                                    ? Colors.white
                                    : Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(provider.currentPage == index
                                      ? 8.r
                                      : 50.r),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30.h),
                    CustomElevatedButton(
                      text: 'View History',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HistoryScreen(user: widget.user),
                          ),
                        );
                      },
                      height: 60.h,
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromARGB(255, 9, 40, 65),
                      borderRadius: 20.r,
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.topRight,
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _bounceAnimation.value,
                            child: child,
                          );
                        },
                        child: GestureDetector(
                          onTap: () => openWhatsApp(context, "+92 300 8497241"),
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/whatsapp.png',
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

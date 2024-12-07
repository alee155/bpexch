import 'package:bpexch/model/user_model.dart';
import 'package:bpexch/view/IndexScreens/DepositTabs/bank.dart';
import 'package:bpexch/view/IndexScreens/DepositTabs/easypaisy.dart';
import 'package:bpexch/view/IndexScreens/DepositTabs/jazzcash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/Reusable/blurred_background.dart';

class DrawerDepositScreen extends StatefulWidget {
  final UserModel user;
  const DrawerDepositScreen({super.key, required this.user});

  @override
  State<DrawerDepositScreen> createState() => _DrawerDepositScreenState();
}

class _DrawerDepositScreenState extends State<DrawerDepositScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    _pageController.jumpToPage(index); // Update PageView when tab changes
  }

  void _onPageChanged(int index) {
    _tabController.index = index; // Update TabBar when page changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
          Positioned(
            top: 20.h,
            left: 10.w,
            right: 10.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Select an account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Transfer funds on selected account and click Transfer Button",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17.sp,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 120.h,
            left: 10.w,
            right: 10.w,
            child: Column(
              children: [
                Container(
                  height: 70.h,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      // TabBar with custom blurred indicator
                      TabBar(
                        controller: _tabController,
                        onTap: _onTabChanged,
                        tabs: const [
                          Tab(text: "Bank"),
                          Tab(text: "Jazz Cash"),
                          Tab(text: "Easypaisa"),
                        ],
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        indicator: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.9),
                              blurRadius: 5,
                            ),
                          ],
                          // Adding the blur filter
                          image: DecorationImage(
                            image:
                                const AssetImage('assets/images/appimage.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.9),
                              BlendMode.dstATop,
                            ),
                          ),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // PageView for content outside of the Container
          Positioned(
            top: 200.h, // Adjust top position to avoid overlap with the TabBar
            left: 10.w,
            right: 10.w,
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  180, // Adjust height for the PageView
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable swipe gesture
                children: [
                  BanksTab(user: widget.user),
                  JazzCashTab(user: widget.user),
                  EasypaisaTab(user: widget.user),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

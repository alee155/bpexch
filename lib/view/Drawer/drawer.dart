import 'package:bpexch/auth/loginscreen.dart';
import 'package:bpexch/model/user_model.dart';
import 'package:bpexch/utils/logout_bottom_sheet.dart';
import 'package:bpexch/utils/saveToken.dart';
import 'package:bpexch/view/ChangePassword/change_password.dart';
import 'package:bpexch/view/TwoScreens/drawer_deposit.dart';
import 'package:bpexch/view/TwoScreens/drawer_withdraw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDrawer extends StatefulWidget {
  final UserModel user; // Add this to accept the UserModel

  const CustomDrawer({super.key, required this.user});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 9, 40, 65),
              ),
              child: CircleAvatar(
                radius: 80.r,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.account_circle,
                  size: 160.r,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/card.svg',
                width: 24.w,
                height: 24.h,
                color: Colors.white,
              ),
              title: const Text('Withdraw'),
              onTap: () {
                Navigator.of(context).pop(true);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DrawerWalletScreen()),
                );
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/deposit.svg',
                width: 24.w,
                height: 24.h,
                color: Colors.white,
              ),
              title: const Text('Deposit'),
              onTap: () {
                Navigator.of(context).pop(true);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DrawerDepositScreen(user: widget.user)),
                );
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/link.svg',
                width: 24.w,
                height: 24.h,
                color: Colors.white,
              ),
              title: const Text('bpexch'),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/lock.svg',
                width: 24.w,
                height: 24.h,
                color: Colors.white,
              ),
              title: const Text('change passowrd'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePassword(user: widget.user)),
                );
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/logout.svg',
                width: 24.w,
                height: 24.h,
                color: Colors.white,
              ),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pop(true);
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return LogoutBottomSheet(
                      onCancel: () {
                        Navigator.of(context).pop(
                            false); // Close the bottom sheet without logging out
                      },
                      onLogout: () async {
                        // Clear the saved token and user data
                        await clearUserData();
                        // Navigate the user to the login screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

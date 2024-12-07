import 'package:bpexch/model/user_model.dart';
import 'package:bpexch/view/IndexScreens/deposit_screen.dart';
import 'package:bpexch/view/IndexScreens/home_screen.dart';
import 'package:bpexch/view/IndexScreens/link_screen.dart';
import 'package:bpexch/view/IndexScreens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarScreen extends StatefulWidget {
  final UserModel user;
  const BottomNavBarScreen({super.key, required this.user});

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  final List<String> _iconPaths = [
    'assets/icons/account.svg',
    'assets/icons/card.svg',
    'assets/icons/deposit.svg',
    'assets/icons/link.svg',
    'assets/icons/whatsapp.svg',
  ];

  // _screens initialization moved to the build method
  late List<Widget> _screens;

  @override
  Widget build(BuildContext context) {
    _screens = [
      AccountScreen(user: widget.user),
      const WalletScreen(),
      DepositScreen(user: widget.user),
      const WebViewScreen(),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: SvgPicture.asset(
              _iconPaths[0],
              width: 30,
              height: 30,
              color: _getIconColor(0),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: SvgPicture.asset(
              _iconPaths[1],
              width: 30,
              height: 30,
              color: _getIconColor(1),
            ),
            label: 'Withdraw',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: SvgPicture.asset(
              _iconPaths[2],
              width: 30,
              height: 30,
              color: _getIconColor(2),
            ),
            label: 'Deposit',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: SvgPicture.asset(
              _iconPaths[3],
              width: 30,
              height: 30,
              color: _getIconColor(3),
            ),
            label: 'Link',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color _getIconColor(int index) {
    return _selectedIndex == index ? Colors.white : Colors.grey;
  }
}

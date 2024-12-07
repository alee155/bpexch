import 'package:bpexch/Service/bank_name_services/bank_service.dart';
import 'package:bpexch/model/GetBank_Model/bank_model.dart';
import 'package:bpexch/model/user_model.dart';
import 'package:bpexch/utils/Reusable/blurred_background.dart';
import 'package:bpexch/utils/saveToken.dart';
import 'package:bpexch/utils/shimmer_effect.dart';
import 'package:bpexch/view/EnterMoneyScreen/enter_money_screen.dart';
import 'package:bpexch/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EasypaisaTab extends StatefulWidget {
  final UserModel user;
  const EasypaisaTab({super.key, required this.user});

  @override
  _EasypaisaTabState createState() => _EasypaisaTabState();
}

class _EasypaisaTabState extends State<EasypaisaTab> {
  late Future<List<Bank>> _banksFuture = Future.value([]);
  String? _token;
  Bank? _selectedBank; // To store the selected Easypaisa bank

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    final token = await getToken(); // Retrieve the token
    if (token != null) {
      _token = token;
      setState(() {
        _banksFuture =
            BankService().fetchBanks(_token!); // Fetch Easypaisa data
      });
    } else {
      print('No token found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          const BlurredBackground(
            imagePath: 'assets/images/appimage.jpg',
            blurSigmaX: 15,
            blurSigmaY: 15,
            opacity: 0.2,
          ),
          Positioned.fill(
            left: 5.w,
            right: 5.w,
            top: 0.h,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 450.h,
                    child: FutureBuilder<List<Bank>>(
                      future: _banksFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Shimmer effect while waiting
                          return buildShimmerEffect();
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData) {
                          final banks = snapshot.data!
                              .where((bank) =>
                                  bank.category.toLowerCase() == 'easypaisa')
                              .toList();

                          if (banks.isEmpty) {
                            return const Center(
                                child: Text('No Easypaisa banks found'));
                          }

                          return ListView.builder(
                            itemCount: banks.length,
                            itemBuilder: (context, index) {
                              final bank = banks[index];
                              return Padding(
                                padding: EdgeInsets.all(8.r),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedBank =
                                          bank; // Set the selected bank
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8.r),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                          color: Colors.white, width: 1.5),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 20.r,
                                          child: bank.image.isNotEmpty
                                              ? Image.network(
                                                  bank.image,
                                                  fit: BoxFit.cover,
                                                  width: 40.r,
                                                  height: 40.r,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      // Image is loaded, show it
                                                      return child;
                                                    } else {
                                                      // Show a loading indicator while the image is loading
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  (loadingProgress
                                                                          .expectedTotalBytes ??
                                                                      1)
                                                              : null,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    // Show an icon if the image fails to load (404 or any other error)
                                                    return Icon(
                                                      Icons
                                                          .account_circle, // Placeholder icon if the image fails to load
                                                      size: 30.r,
                                                      color: Colors.white,
                                                    );
                                                  },
                                                )
                                              : Icon(
                                                  Icons
                                                      .account_circle, // Placeholder icon if no image is provided
                                                  size: 30.r,
                                                  color: Colors.white,
                                                ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              bank.name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Ac # ${bank.acNumber}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                            Text(
                                              "Ac Title # ${bank.acTitle}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Checkbox(
                                          value: _selectedBank == bank,
                                          onChanged: (bool? selected) {
                                            setState(() {
                                              if (selected == true) {
                                                _selectedBank = bank;
                                              } else {
                                                _selectedBank = null;
                                              }
                                            });
                                          },
                                          activeColor: Colors.green,
                                          checkColor: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text('No data found'));
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Transfer button
                  CustomElevatedButton(
                    text: 'Transfer',
                    onPressed: _selectedBank == null
                        ? () {}
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EnterMoneyAmount(
                                    bank: _selectedBank!, user: widget.user),
                              ),
                            );
                          },
                    height: 50.h,
                    width: 250.w,
                    color: _selectedBank == null ? Colors.grey : Colors.green,
                    borderRadius: 20.r,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

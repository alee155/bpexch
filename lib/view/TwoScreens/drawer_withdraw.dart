import 'package:bpexch/model/user_model.dart';
import 'package:bpexch/utils/Reusable/blurred_background.dart';
import 'package:bpexch/utils/text_styles.dart';
import 'package:bpexch/utils/time_helper.dart';
import 'package:bpexch/utils/withdraw_helper.dart';
import 'package:bpexch/widgets/custom_container.dart';
import 'package:bpexch/widgets/custom_elevated_button.dart';
import 'package:bpexch/widgets/payment_method_widget.dart';
import 'package:bpexch/widgets/wallet_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class DrawerWalletScreen extends StatefulWidget {
//   final UserModel user;
//   const DrawerWalletScreen({super.key, required this.user});

//   @override
//   State<DrawerWalletScreen> createState() => _DrawerWalletScreenState();
// }

// class _DrawerWalletScreenState extends State<DrawerWalletScreen> {
//   final FocusNode _amountFocusNode = FocusNode();
//   final FocusNode _accountDetailsFocusNode = FocusNode();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _accountDetailsController =
//       TextEditingController();
//   String payment_method = '';
//   String description = '';

//   bool get isFormValid =>
//       _amountController.text.isNotEmpty &&
//       payment_method.isNotEmpty &&
//       _accountDetailsController.text.isNotEmpty;

//   bool isWithinRange = false;
//   String formattedFromTime = '';
//   String formattedToTime = '';

//   Future<void> _fetchTime() async {
//     try {
//       final timeData = await TimeAPI.fetchTime();
//       setState(() {
//         formattedFromTime = timeData['formattedFromTime'];
//         formattedToTime = timeData['formattedToTime'];
//         isWithinRange = timeData['isWithinRange'];
//       });
//     } catch (error) {
//       print("Error: $error");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchTime();
//     print("******isWithinRange: $isWithinRange");
//   }

//   @override
//   void dispose() {
//     _amountFocusNode.dispose();
//     _accountDetailsFocusNode.dispose();
//     _amountController.dispose();
//     _accountDetailsController.dispose();
//     super.dispose();
//   }

//   Future<void> _onWithdrawPressed() async {
//     if (!isFormValid) return;

//     WithdrawHelper.handleWithdraw(
//       context: context,
//       amountController: _amountController,
//       accountDetailsController: _accountDetailsController,
//       paymentMethod: payment_method,
//       onSuccess: () {
//         setState(() {
//           _amountController.clear();
//           _accountDetailsController.clear();
//           payment_method = '';
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           "Withdraw Balance",
//           style: WallatTextStyle.titleStyle,
//         ),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//         ),
//       ),
//       body: Stack(
//         children: [
//           const BlurredBackground(
//               imagePath: 'assets/images/appimage.jpg',
//               blurSigmaX: 15,
//               blurSigmaY: 15,
//               opacity: 0.2),
//           Positioned.fill(
//             top: 20.h,
//             left: 10.w,
//             right: 10.w,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Bp username",
//                         style: WallatTextStyle.subtitleStyle,
//                       ),
//                       Text(
//                         widget.user.bpUsername ?? 'N/A',
//                         style: WallatTextStyle.subtitleStyle,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10.h),
//                   Text(
//                     "Amount to withdraw",
//                     style: WallatTextStyle.subtitleStyle,
//                   ),
//                   SizedBox(height: 5.h),
//                   CustomAmountTextField(
//                     focusNode: _amountFocusNode,
//                     controller: _amountController,
//                     hintText: "Enter amount you want to withdraw",
//                     onChanged: (value) {
//                       payment_method = value.trim();
//                     },
//                   ),
//                   SizedBox(height: 10.h),
//                   Text(
//                     "Account Details",
//                     style: WallatTextStyle.subtitleStyle,
//                   ),
//                   SizedBox(height: 5.h),
//                   CustomContainer(
//                     height: 400.h,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Choose Payment Method",
//                             style: WallatTextStyle.subtitleStyle,
//                           ),
//                           SizedBox(height: 10.h),
//                           PaymentMethodWidget(
//                             image: 'assets/images/banklogo.png',
//                             label: 'Bank',
//                             value: 'bank',
//                             imageHeight: 40.h,
//                             onPaymentMethodSelected: (selectedMethod) {
//                               setState(() {
//                                 payment_method = selectedMethod;
//                               });
//                             },
//                           ),
//                           SizedBox(height: 10.h),
//                           PaymentMethodWidget(
//                             image: 'assets/images/jazzcashlogo.png',
//                             label: 'Jazz Cash',
//                             value: 'jazzcash',
//                             imageHeight: 20.h,
//                             onPaymentMethodSelected: (selectedMethod) {
//                               setState(() {
//                                 payment_method = selectedMethod;
//                               });
//                             },
//                           ),
//                           SizedBox(height: 10.h),
//                           PaymentMethodWidget(
//                             image: 'assets/images/easypaisalogo.png',
//                             label: 'EasyPaisa',
//                             value: 'easypaisa',
//                             imageHeight: 40.h,
//                             onPaymentMethodSelected: (selectedMethod) {
//                               setState(() {
//                                 payment_method = selectedMethod;
//                               });
//                             },
//                           ),
//                           SizedBox(height: 5.h),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: DrawerWithdraw(
//                               focusNode: _accountDetailsFocusNode,
//                               controller: _accountDetailsController,
//                               onChanged: (value) {
//                                 setState(() {
//                                   description = value.trim();
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//                   Column(
//                     children: [
//                       if (isWithinRange) ...[
//                         CustomElevatedButton(
//                           text: 'Withdraw',
//                           onPressed: isFormValid ? _onWithdrawPressed : null,
//                           height: 60.h,
//                           width: MediaQuery.of(context).size.width,
//                           color: isFormValid ? Colors.green : Colors.grey,
//                           borderRadius: 20.r,
//                         ),
//                       ] else ...[
//                         Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             "Valid Time Range: $formattedFromTime - $formattedToTime",
//                             style: WallatTextStyle.subtitleStyle,
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                       ],
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class DrawerWalletScreen extends StatefulWidget {
  final UserModel user;

  const DrawerWalletScreen({
    super.key,
    required this.user,
  });

  @override
  State<DrawerWalletScreen> createState() => _DrawerWalletScreenState();
}

class _DrawerWalletScreenState extends State<DrawerWalletScreen> {
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _accountDetailsFocusNode = FocusNode();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountDetailsController =
      TextEditingController();
  String payment_method = '';
  String description = '';

  bool isWithinRange = false;
  String formattedFromTime = '';
  String formattedToTime = '';

  Future<void> _fetchTime() async {
    try {
      final timeData = await TimeAPI.fetchTime();
      setState(() {
        formattedFromTime = timeData['formattedFromTime'];
        formattedToTime = timeData['formattedToTime'];
        isWithinRange = timeData['isWithinRange'];
      });
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTime();
    print("******isWithinRange: $isWithinRange");
  }

  @override
  void dispose() {
    _amountFocusNode.dispose();
    _accountDetailsFocusNode.dispose();
    _amountController.dispose();
    _accountDetailsController.dispose();
    super.dispose();
  }

  Future<void> _onWithdrawPressed() async {
    WithdrawHelper.handleWithdraw(
      context: context,
      amountController: _amountController,
      accountDetailsController: _accountDetailsController,
      paymentMethod: payment_method,
      onSuccess: () {
        setState(() {
          _amountController.clear();
          _accountDetailsController.clear();
          payment_method = '';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Withdraw Balance",
          style: WallatTextStyle.titleStyle,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          const BlurredBackground(
              imagePath: 'assets/images/appimage.jpg',
              blurSigmaX: 15,
              blurSigmaY: 15,
              opacity: 0.2),
          Positioned.fill(
            top: 10.h,
            left: 10.w,
            right: 10.w,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bp username",
                        style: WallatTextStyle.subtitleStyle,
                      ),
                      Text(
                        widget.user.bpUsername ?? 'N/A',
                        style: WallatTextStyle.subtitleStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Amount to withdraw",
                    style: WallatTextStyle.subtitleStyle,
                  ),
                  SizedBox(height: 5.h),
                  CustomAmountTextField(
                    focusNode: _amountFocusNode,
                    controller: _amountController,
                    hintText: "Enter amount you want to withdraw",
                    onChanged: (value) {
                      payment_method = value.trim();
                    },
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Account Details",
                    style: WallatTextStyle.subtitleStyle,
                  ),
                  SizedBox(height: 5.h),
                  CustomContainer(
                    height: 400.h,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Choose Payment Method",
                            style: WallatTextStyle.subtitleStyle,
                          ),
                          SizedBox(height: 10.h),
                          PaymentMethodWidget(
                            image: 'assets/images/banklogo.png',
                            label: 'Bank',
                            value: 'bank',
                            imageHeight: 40.h,
                            onPaymentMethodSelected: (selectedMethod) {
                              setState(() {
                                payment_method = selectedMethod;
                              });
                            },
                          ),
                          SizedBox(height: 10.h),
                          PaymentMethodWidget(
                            image: 'assets/images/jazzcashlogo.png',
                            label: 'Jazz Cash',
                            value: 'jazzcash',
                            imageHeight: 20.h,
                            onPaymentMethodSelected: (selectedMethod) {
                              setState(() {
                                payment_method = selectedMethod;
                              });
                            },
                          ),
                          SizedBox(height: 10.h),
                          PaymentMethodWidget(
                            image: 'assets/images/easypaisalogo.png',
                            label: 'EasyPaisa',
                            value: 'easypaisa',
                            imageHeight: 40.h,
                            onPaymentMethodSelected: (selectedMethod) {
                              setState(() {
                                payment_method = selectedMethod;
                              });
                            },
                          ),
                          SizedBox(height: 5.h),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DrawerWithdraw(
                              focusNode: _accountDetailsFocusNode,
                              controller: _accountDetailsController,
                              onChanged: (value) {
                                setState(() {
                                  description = value.trim();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Column(
                    children: [
                      if (isWithinRange) ...[
                        CustomElevatedButton(
                          text: 'Withdraw',
                          onPressed: _onWithdrawPressed,
                          height: 60.h,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.green, // Always green
                          borderRadius: 20.r,
                        ),
                      ] else ...[
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Valid Time Range: $formattedFromTime - $formattedToTime",
                            style: WallatTextStyle.subtitleStyle,
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

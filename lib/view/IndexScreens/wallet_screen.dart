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
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WalletScreen extends StatefulWidget {
  final UserModel user;
  const WalletScreen({super.key, required this.user});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _accountDetailsFocusNode = FocusNode();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountDetailsController =
      TextEditingController();
  bool isLoading = false;
  String payment = '';
  String payment_method = '';
  String description = '';
  late String currentTime;

  bool get isFormValid =>
      _amountController.text.isNotEmpty &&
      payment_method.isNotEmpty &&
      _accountDetailsController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    currentTime = "${now.hour}:${now.minute}:${now.second}";
    print("***************Current Time: $currentTime ***************");

    // Add listeners to validate the form whenever a value changes.
    _amountController.addListener(() {
      setState(() {}); // Updates the form validity
    });
    _accountDetailsController.addListener(() {
      setState(() {}); // Updates the form validity
    });
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
    if (!isFormValid) return; // Prevent button press if form is invalid.

    setState(() {
      isLoading = true; // Show the loading animation
    });

    // Validate the current time first
    final timeValidationResult = await TimeHelper.validateTime(currentTime);

    if (timeValidationResult['isWithinRange'] == true) {
      print(timeValidationResult['message']);

      // Handle the withdrawal action
      WithdrawHelper.handleWithdraw(
        context: context,
        amountController: _amountController,
        accountDetailsController: _accountDetailsController,
        paymentMethod: payment_method,
        onSuccess: () {
          // After successful withdrawal, reset the state
          setState(() {
            _amountController.clear();
            _accountDetailsController.clear();
            payment_method = '';
            isLoading = false; // Stop loading animation
          });
        },
      );
    } else {
      // If time is invalid, show error dialog and stop loading animation
      print(timeValidationResult['message']);
      TimeHelper.showErrorDialog(context, timeValidationResult['message']);
      setState(() {
        isLoading = false; // Stop loading animation
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BlurredBackground(
              imagePath: 'assets/images/appimage.jpg',
              blurSigmaX: 15,
              blurSigmaY: 15,
              opacity: 0.2),
          Positioned(
            top: 40.h,
            left: 10.w,
            right: 10.w,
            child: Center(
              child: Text(
                "Withdraw Balance",
                style: WallatTextStyle.titleStyle,
              ),
            ),
          ),
          Positioned.fill(
            top: 80.h,
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
                        widget.user.bpUsername ?? 'N/A',
                        style: WallatTextStyle.subtitleStyle,
                      ),
                      Text(
                        widget.user.bpPassword ?? 'N/A',
                        style: WallatTextStyle.subtitleStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
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
                      payment = value.trim();
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Account Details",
                    style: WallatTextStyle.subtitleStyle,
                  ),
                  SizedBox(height: 5.h),
                  CustomContainer(
                    height: 400.h,
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
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomAccountDetailsTextField(
                            focusNode: _accountDetailsFocusNode,
                            controller: _accountDetailsController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  isLoading
                      ? Center(
                          child: SpinKitFadingCircle(
                            color: Colors.green,
                            size: 60.r,
                          ),
                        )
                      : CustomElevatedButton(
                          text: 'Withdraw',
                          onPressed: isFormValid ? _onWithdrawPressed : null,
                          height: 60.h,
                          width: MediaQuery.of(context).size.width,
                          color: isFormValid ? Colors.green : Colors.grey,
                          borderRadius: 20.r,
                        ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

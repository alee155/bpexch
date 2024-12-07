import 'package:bpexch/model/GetBank_Model/bank_model.dart';
import 'package:bpexch/model/user_model.dart';
import 'package:bpexch/utils/Reusable/blurred_background.dart';
import 'package:bpexch/view/TransferMoney/transfer_money.dart';
import 'package:bpexch/widgets/custom_elevated_button.dart';
import 'package:bpexch/widgets/wallet_textfiled.dart';
import 'package:flutter/material.dart';

class EnterMoneyAmount extends StatefulWidget {
  final Bank bank;
  final UserModel user;
  const EnterMoneyAmount({super.key, required this.bank, required this.user});

  @override
  _EnterMoneyAmountState createState() => _EnterMoneyAmountState();
}

class _EnterMoneyAmountState extends State<EnterMoneyAmount> {
  final FocusNode _amountFocusNode = FocusNode();
  final TextEditingController _amountdepositController =
      TextEditingController();

  bool _isAmountValid = false; // Track if the entered amount is valid

  @override
  void initState() {
    super.initState();
    // Print the entire Bank object data
    print("Bank ID: ${widget.bank.id}");
    print("Bank Name: ${widget.bank.name}");
    print("Account Title: ${widget.bank.acTitle}");
    print("Account Number: ${widget.bank.acNumber}");
    print("Category: ${widget.bank.category}");
    print("Image URL: ${widget.bank.image}");

    // Listen to changes in the amount field
    _amountdepositController.addListener(_validateAmount);
  }

  void _validateAmount() {
    double? enteredAmount = double.tryParse(_amountdepositController.text);
    if (enteredAmount != null && enteredAmount >= 500) {
      setState(() {
        _isAmountValid = true; // Valid amount
      });
    } else {
      setState(() {
        _isAmountValid = false; // Invalid amount
      });
    }
  }

  @override
  void dispose() {
    _amountFocusNode.dispose();
    _amountdepositController.dispose();
    super.dispose();
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
            opacity: 0.2,
          ),
          Positioned(
            top: 30,
            left: 10,
            right: 10,
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Add Amount!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: const TextSpan(
                    text:
                        "Enter amount you want to deposit in My Wallet, Minimum amount is ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    children: [
                      TextSpan(
                        text: "Rs.500",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                CustomAmountTextField(
                  focusNode: _amountFocusNode,
                  hintText: "Enter amount you want to deposit",
                  controller: _amountdepositController,
                  onChanged: (value) {
                    _validateAmount(); // Call your validation function when the text changes
                  },
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Next',
                  onPressed: _isAmountValid
                      ? () {
                          double enteredAmount = double.parse(
                              _amountdepositController
                                  .text); // Get the entered amount
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransferMoneyScreen(
                                bank: widget.bank, // Pass the Bank model object
                                amount: enteredAmount,
                                 user: widget.user,
                              ),
                            ),
                          );
                        }
                      : () {}, // Empty function when invalid
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: _isAmountValid ? Colors.green : Colors.grey,
                  borderRadius: 20,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

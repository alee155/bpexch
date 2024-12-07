import 'dart:io';
import 'dart:ui';

import 'package:bpexch/model/GetBank_Model/bank_model.dart';
import 'package:bpexch/model/user_model.dart';
import 'package:bpexch/utils/Reusable/blurred_background.dart';
import 'package:bpexch/utils/Reusable/image_picker_bottom_sheet.dart';
import 'package:bpexch/utils/Reusable/instructions_widget.dart';
import 'package:bpexch/utils/copy_bank_details.dart';
import 'package:bpexch/utils/saveToken.dart';
import 'package:bpexch/view/BottomNavBar/bottomnavbar.dart';
import 'package:bpexch/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class TransferMoneyScreen extends StatefulWidget {
  final Bank bank;
  final double amount;
  final UserModel user;

  const TransferMoneyScreen(
      {super.key,
      required this.bank,
      required this.amount,
      required this.user});

  @override
  _TransferMoneyScreenState createState() => _TransferMoneyScreenState();
}

class _TransferMoneyScreenState extends State<TransferMoneyScreen> {
  File? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    print("Bank ID: ${widget.bank.id}");
    print("Bank Name: ${widget.bank.name}");
    print("Account Title: ${widget.bank.acTitle}");
    print("Account Number: ${widget.bank.acNumber}");
    print("Category: ${widget.bank.category}");
    print("Image URL: ${widget.bank.image}");
    print("Amount: ${widget.amount}");
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
            top: 30.h,
            left: 10.w,
            right: 10.w,
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
            top: 90.h,
            left: 10.w,
            right: 10.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transfer Funds!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h),
                RichText(
                  text: TextSpan(
                    text: "Transfer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                    children: [
                      TextSpan(
                        text: " Rs.${widget.amount}",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            " to the below account, attach payment proof, and click submit.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 190.h,
            left: 10.w,
            right: 10.h,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: _buildBlurredCard(
                      context,
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.bank.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Ac # ${widget.bank.acNumber}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.sp),
                                ),
                                Text(
                                  "Ac Tittle # ${widget.bank.acTitle}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.sp),
                                ),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                copyBankDetails(
                                  context,
                                  widget.bank.name,
                                  widget.bank.acNumber,
                                  widget.bank.acTitle,
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/icons/copy.svg',
                                height: 24.h,
                                width: 24.w,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Upload Payment Proof",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: _buildBlurredCard(
                      context,
                      height: 200.h,
                      showCameraIcon: true,
                      image: _selectedImage,
                      onCancel: _onCancel,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const Text(
                    "instructions",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.h),
                  const EnglishInstructions(),
                  SizedBox(height: 5.h),
                  const UrduInstructions(),
                  SizedBox(height: 20.h),
                  CustomElevatedButton(
                    text: 'SUBMIT',
                    onPressed: _isLoading
                        ? () {} // Empty function when loading, preventing any interaction
                        : () {
                            if (_selectedImage == null) {
                              const snackBar = SnackBar(
                                content: Text(
                                  'Please select the image and then proceed',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              _uploadReceipt();
                            }
                          },
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.green,
                    borderRadius: 20,
                  ),
                  const SizedBox(
                      height: 20), // Add space between button and loader
                  _isLoading
                      ? Center(
                          child: SpinKitFadingCircle(
                            color: Colors.green,
                            size: 60.r,
                          ),
                        )
                      : const SizedBox(), // Only show loader when _isLoading is true

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurredCard(
    BuildContext context, {
    Widget? child,
    double height = 80,
    bool showCameraIcon = false,
    File? image,
    VoidCallback? onCancel,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: Container(
          height: height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white),
          ),
          child: Stack(
            children: [
              if (image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    image,
                    fit: BoxFit.contain,
                    height: height,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              if (child != null) child,
              if (image != null)
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: onCancel,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/icons/cross.svg',
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              if (showCameraIcon)
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => ImagePickerBottomSheet.show(
                      context: context,
                      onGalleryTap: _pickImageFromGallery,
                      onCameraTap: _pickImageFromCamera,
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/icons/pic.svg',
                          height: 24,
                          width: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _onCancel() {
    setState(() {
      _selectedImage = null;
    });
  }

  Future<void> _uploadReceipt() async {
    setState(() {
      _isLoading = true;
    });

    final token = await getToken();
    if (token == null) {
      setState(() {
        _isLoading = false;
      });
      const snackBar = SnackBar(
        content: Text(
          "Authorization failed. Please log in.",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    final uri = Uri.parse('https://bpexchdeals.com/api/reciept');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['type'] = '1'
      ..fields['reciept'] = widget.amount.toString()
      ..fields['bank_id'] = widget.bank.id.toString()
      ..fields['payment_method'] = widget.bank.name
      ..fields['account'] = widget.bank.acNumber;

    if (_selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        _selectedImage!.path,
      ));
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        const snackBar = SnackBar(
          content: Text(
            "Transfer initiated successfully!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBarScreen(user: widget.user),
          ),
        );
      } else {
        const snackBar = SnackBar(
          content: Text(
            "Failed to upload receipt. Try again.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      final snackBar = SnackBar(
        content: Text(
          "Error occurred: $e",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

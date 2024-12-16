import 'dart:ui';

import 'package:bpexch/Service/fetchTransactionDetails_service.dart';
import 'package:bpexch/Service/transaction_services.dart';
import 'package:bpexch/model/transaction_model.dart';
import 'package:bpexch/model/user_model.dart';
import 'package:bpexch/utils/Reusable/blurred_background.dart';
import 'package:bpexch/utils/shimmer_effect.dart';
import 'package:bpexch/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryScreen extends StatefulWidget {
  final UserModel user;

  const HistoryScreen({super.key, required this.user});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<Transaction>> _transactions;
  bool _isLoading = false; // Add a loading state

  @override
  void initState() {
    super.initState();
    _transactions = fetchTransactionHistory(widget.user.id);
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
        title: Text(
          'History',
          style: AppTextStyles.whiteText(20),
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
          FutureBuilder<List<Transaction>>(
            future: _transactions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildShimmerEffect();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'No Record Found',
                    style: AppTextStyles.whiteText(16),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No transactions found.',
                    style: AppTextStyles.whiteText(16),
                  ),
                );
              }

              final transactions = snapshot.data!;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ListView.builder(
                  itemCount: transactions.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          _isLoading = true; // Set loading to true when tapping
                        });
                        await fetchTransactionDetails(context, transaction.id);
                        setState(() {
                          _isLoading =
                              false; // Set loading to false after fetching
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10.r),
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    transaction.type ==
                                                            'withdraw'
                                                        ? 'assets/icons/withdr.svg'
                                                        : 'assets/icons/depo.svg',
                                                    width: 30.w,
                                                    height: 30.h,
                                                    color: transaction.type ==
                                                            'withdraw'
                                                        ? Colors.red
                                                        : Colors.green,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    transaction.type,
                                                    style:
                                                        AppTextStyles.whiteText(
                                                            17),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Bank: ${transaction.bank}',
                                                style:
                                                    AppTextStyles.whiteText(15),
                                              ),
                                              Text(
                                                'Ac#: ${transaction.accountNumber}',
                                                style:
                                                    AppTextStyles.whiteText(15),
                                              ),
                                              Text(
                                                'Ac#: ${transaction.accountTitle}',
                                                style:
                                                    AppTextStyles.whiteText(15),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Rs.${transaction.amount}',
                                            style: AppTextStyles.greenText(17),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                          color: Colors.white, thickness: 1.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            transaction.status,
                                            style: AppTextStyles.redText(17),
                                          ),
                                          if (transaction.status ==
                                                  'Approved' &&
                                              transaction.type == 'withdraw')
                                            GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  _isLoading =
                                                      true; // Set loading to true when tapping
                                                });
                                                await fetchTransactionDetails(
                                                    context, transaction.id);
                                                setState(() {
                                                  _isLoading =
                                                      false; // Set loading to false after fetching
                                                });
                                              },
                                              child: Text(
                                                'Deposit slip',
                                                style:
                                                    AppTextStyles.blueText(16),
                                              ),
                                            ),
                                          Text(
                                            transaction.date,
                                            style: AppTextStyles.whiteText(15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Positioned.fill(
                                    child: Opacity(
                                      opacity: 0.1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.r),
                                          child: Image.asset(
                                            transaction.status == 'Approved'
                                                ? 'assets/images/approved.jpg'
                                                : transaction.status ==
                                                        'Rejected'
                                                    ? 'assets/images/rej.jpg'
                                                    : 'assets/images/pending.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          if (_isLoading)
            Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Center(
                  child: SpinKitFadingCircle(
                    color: Colors.green,
                    size: 60.r,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
